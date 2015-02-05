class Monument < ActiveRecord::Base
  belongs_to :collection, :class_name => "Collection", :foreign_key => "collection_id"
  has_one :user, :class_name => "User", through: :collection  # for the join
  has_many :pictures, :class_name => "Picture", :foreign_key => "monument_id", dependent: :destroy
  has_and_belongs_to_many :categories, :join_table => "categories_monuments"
  
  validates_presence_of :name, :message => "can't be blank"
  validates_presence_of :description, :message => "can't be blank"
  validates_presence_of :collection_id, :message => "has to belong to a collection"

  accepts_nested_attributes_for :categories
end
