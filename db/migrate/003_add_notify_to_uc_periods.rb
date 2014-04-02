class AddNotifyToUcPeriods < ActiveRecord::Migration
  def change
    add_column :uc_periods, :notify, :boolean, :default => false
  end
end