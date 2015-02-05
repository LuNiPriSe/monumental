class AddDefaultValuesToMonument < ActiveRecord::Migration
  def up
    change_column :monuments, :public, :boolean, :default => false
    change_column :monuments, :public_aproved, :boolean, :default => false
  end

  def down
    change_column :monuments, :public, :boolean, :default => nil
    change_column :monuments, :public_aproved, :boolean, :default => nil
  end
end
