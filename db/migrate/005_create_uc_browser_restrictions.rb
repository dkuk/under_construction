class CreateUcBrowserRestrictions < ActiveRecord::Migration
  def self.up
    create_table :uc_browser_restrictions do |t|
      t.string :name
      t.string :condition
      t.string :version
      t.timestamps
    end
  end

  def self.down
    drop_table :uc_browser_restrictions
  end
end