class Photo < ActiveRecord::Base
  belongs_to :post

  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>", :large => "650x650>" }

  validates_attachment_presence :image, :message => "Can't be blank"
  validates_attachment_size :image, :less_than => 5.megabytes
  validates_attachment_content_type :image, :content_type => ['image/jpeg', 'image/png']

  
end
