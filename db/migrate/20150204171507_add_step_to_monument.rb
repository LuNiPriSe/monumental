class AddStepToMonument < ActiveRecord::Migration
  def change
    add_column :monuments, :step, :integer
  end
end
