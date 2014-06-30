class CreateControllerRestrictions < ActiveRecord::Migration
  def change
    create_table :controller_restrictions do |t|
      t.integer :uc_period_id
      t.string :name, default: ''
    end
  end
end