class Category < ActiveRecord::Base
  has_and_belongs_to_many :monuments, :join_table => "categories_monuments"
  
  validates_presence_of :name, :message => "can't be blank"
end
