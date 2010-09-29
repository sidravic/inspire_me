class User < ActiveRecord::Base
  acts_as_authentic do |c|
    c.login_field = "email"
  end
  
  validates_uniqueness_of :username
  validates_presence_of :username

  has_many :posts, :dependent => :destroy

  named_scope :active, :conditions => {:activated => true}

  def activate
    transaction do
      self.activated = true
      self.reset_perishable_token
    end
  end
end
