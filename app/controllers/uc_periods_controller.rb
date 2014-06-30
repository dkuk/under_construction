class UcPeriodsController < ApplicationController

  layout 'admin'

  before_filter :find_default_period, :only => [:index, :under_construction]
  before_filter :require_admin, :except => [:update_msg_head, :under_construction]

  $ROUTES_LIST = []

  def self.get_routes_list
    if not $ROUTES_LIST.any?
      Rails.application.reload_routes!
      $ROUTES_LIST = Rails.application.routes.routes.group_by{|route| route.defaults[:controller]}.collect do |controller, values|
        actions = []
        values.each do |v|
          actions << v.defaults[:action]
        end
        actions = actions.reject{|action| action.nil? || action.empty?}.uniq
        {controller: controller.to_s, actions: actions}
      end
    end
    $ROUTES_LIST
  end

  def index
    @uc_period ||= UcPeriod.new
    #@uc_period_controllers ||= @uc_period.controller_restrictions.build
    @routes_list = UcPeriodsController.get_routes_list
    @controllers_list ||= @routes_list.map{|route| route[:controller]}.sort

    render 'show'
  end

  def update_msg_head
    @uc_period = UcPeriod.new(params[:uc_period])
    render :partial => 'update_msg_head'
  end

  def edit
    @uc_period = UcPeriod.find(params[:id])
  end

  def create
    Rails.logger.debug "<<<< #{params[:uc_period]}"
    @uc_period = UcPeriod.new(params[:uc_period])

    respond_to do |format|
      if @uc_period.save
        @uc_period.notify_users if params[:notify_users]
        flash[:notice] = l(:notice_tech_period_saved)
        format.html { redirect_to(:action => 'index') }
      else
        format.html { render 'show' }
      end
    end
  end

  def update
    @uc_period = UcPeriod.find(params[:id])

    respond_to do |format|
      if @uc_period.update_attributes(params[:uc_period])
        @uc_period.notify_users if @uc_period.notify
        flash[:notice] = l(:notice_tech_period_saved)
        format.html { redirect_to(:action => 'index') }
      else
        format.html { render 'show' }
      end
    end
  end

  def under_construction
    render 'under_construction', :layout => false
  end

  def preview
    @uc_period = UcPeriod.new(params[:uc_period])
    @notes = (@uc_period.txt_to_notify || @uc_period.custom_message).to_s
    render 'preview.html', layout: false
  end

  private

  def require_admin
    render_403 unless User.current.admin?
  end

  def find_default_period
    @uc_period = UcPeriod.order('begin_date desc').first
  end

end
