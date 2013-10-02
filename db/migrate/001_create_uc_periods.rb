class CreateUcPeriods < ActiveRecord::Migration
  def self.up
    create_table :uc_periods do |t|
      t.datetime :begin_date
      t.datetime :end_date
      t.string :custom_message
      t.boolean :turned_on, :default => false
      t.timestamps
    end
  end

  def self.down
    drop_table :uc_periods
  end
end