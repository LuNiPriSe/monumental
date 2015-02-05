class Picture < ActiveRecord::Base
  
  belongs_to :monument, :class_name => "Monument", :foreign_key => "monument_id"
  has_one :user, :class_name => "User", through: :monument  # for the join
  
  has_attached_file :file, 
                    :styles => { :medium => "300x300>", :thumb => "100x100>" },
                    :url  => "/assets/images/:monument_id/:id/:style.:extension",
                    :path => ":rails_root/public/assets/images/:monument_id/:id/:style.:extension"

  validates_presence_of :file, :message => "can't be blank"
  validates_presence_of :monument_id, :message => "needs a monument"
  validates_presence_of :name, :message => "can't be blank"
  validates_presence_of :description, :message => "can't be blank"
  validates_attachment_content_type :file, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
  
 
end
