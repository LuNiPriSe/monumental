class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.string :name
      t.datetime :date
      t.text :description
      t.integer :monument_id
      t.attachment :file

      t.timestamps
    end
  end
end
