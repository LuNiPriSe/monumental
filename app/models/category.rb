class Category < ActiveRecord::Base
  has_and_belongs_to_many :monuments, :join_table => "categories_monuments", :foreign_key => "monument_id"
end