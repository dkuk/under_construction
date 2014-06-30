class CreateActionRestrictions < ActiveRecord::Migration
  def change
    create_table :action_restrictions do |t|
      t.integer :controller_restriction_id
      t.string :name, default: ''
    end
  end
end