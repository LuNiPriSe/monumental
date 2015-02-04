class Collection < ActiveRecord::Base
  
  has_many :monuments, :class_name => "Monument", :foreign_key => "collection_id"
  belongs_to :user, :class_name => "User", :foreign_key => "user_id"
  
  validates_presence_of :name, :message => "can't be blank"
  validates_presence_of :user_id, :on => :create, :message => "needs an owner"
  # validates_uniqueness_of :name, :on => :create, :message => "must be unique"   # NOT SPECIFIED
end
