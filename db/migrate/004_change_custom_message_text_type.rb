class ChangeCustomMessageTextType < ActiveRecord::Migration
  def self.up
    change_column :uc_periods, :custom_message,  :text
  end

  def self.down
    change_column :uc_periods, :custom_message,  :string
  end
end