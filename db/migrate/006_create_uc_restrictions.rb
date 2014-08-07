class CreateUcRestrictions < ActiveRecord::Migration
  def change
    create_table :uc_restrictions do |t|
      t.integer :uc_period_id
      t.string :controller, default: ''
      t.string :action, default: ''
    end
  end
end