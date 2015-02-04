class Picture < ActiveRecord::Base
  belongs_to :monument, :class_name => "Monument", :foreign_key => "monument_id"
  
  has_attached_file :file, 
                    :styles => { :medium => "300x300>", :thumb => "100x100>" },
                    :url  => "/assets/images/:monument_id/:id/:basename.:extension",
                    :path => ":rails_root/public/assets/images/:monument_id/:id/:basename.:extension"

 
end
