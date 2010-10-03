class Post < ActiveRecord::Base
  belongs_to :user
  has_many :photos, :dependent => :destroy

  validates_presence_of :title

  def update_post(params)    
    transaction do
      self.update_attributes!(params[:post])
      photo = self.photos.last
      photo.update_attributes!(params[:photo])
    end
    return true
  rescue => e    
    return false
  end
end
