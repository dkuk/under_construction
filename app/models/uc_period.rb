class UcPeriod < ActiveRecord::Base
  unloadable

  belongs_to :user
  has_many :controller_restrictions, :dependent => :destroy

  attr_accessible :controller_restrictions_attributes
  accepts_nested_attributes_for :controller_restrictions

  def active?(time=nil)
    # get current server time (with timezone)
    # setuped time in DB saved as UTC +00. So compare as current server time without timezone
    time ||= DateTime.now
    turned_on && begin_date && begin_date-time.utc_offset <= time && end_date && end_date-time.utc_offset > time
  end

  def planning?(time=nil)
    time ||= DateTime.now
    turned_on && begin_date && begin_date-time.utc_offset > time
  end

  def manual_off?(time=nil)
    time ||= DateTime.now
    !turned_on && begin_date && begin_date-time.utc_offset <= time && end_date && end_date-time.utc_offset > time
  end


  def notify_users
    return unless Redmine::Plugin::registered_plugins.include?(:redmine_sender)

    User.active.each{|u|
      text_message = txt_to_notify
      u.send_message(text_message, 'xmpp') if text_message
    }
  end

  def txt_to_notify(add_body=true)
    msg = nil
    time = DateTime.now
    to = time.utc_offset

    if active?(time)
      msg = l(:label_dear_colleagues)+"\n\n"
      msg << l(:infromation_technical_operations_emergency, :time_end => format_time(end_date-to))+"\n\n"
      msg << custom_message if add_body && custom_message && custom_message != ''
    elsif planning?(time)
      msg = l(:label_dear_colleagues)+"\n\n"
      msg << l(:infromation_technical_operations_planing, :time_start => format_time(begin_date-to), :time_end => format_time(end_date-to))+"\n\n"
      msg << custom_message if add_body && custom_message && custom_message != ''
    # elsif manual_off?(time)
    #   msg = l(:label_dear_colleagues)+"\n\n"
    #   msg << l(:infromation_technical_operations_ends)
    else
      msg = custom_message if add_body
    end
    msg
  end

end