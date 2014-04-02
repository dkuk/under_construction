class AddUserIdToUcPeriods < ActiveRecord::Migration
  def change
    add_column :uc_periods, :user_id, :integer, :null => false
  end
end