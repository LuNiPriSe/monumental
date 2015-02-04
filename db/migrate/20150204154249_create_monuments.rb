class CreateMonuments < ActiveRecord::Migration
  def change
    create_table :monuments do |t|
      t.string :name
      t.text :description
      t.boolean :public
      t.boolean :public_aproved

      t.timestamps
    end
  end
end
