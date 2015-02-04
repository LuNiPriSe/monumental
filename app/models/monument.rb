class Monument < ActiveRecord::Base
  belongs_to :collection, :class_name => "Collection", :foreign_key => "collection_id"
  
  validates_presence_of :name, :message => "can't be blank"
  validates_presence_of :description, :message => "can't be blank"
  validates_presence_of :collection_id, :message => "has to belong to a collection"
end
