class AddTimestampsToUcRestrictions < ActiveRecord::Migration
  def change
    add_column :uc_restrictions, :timestamps, :string, default: false
  end
end