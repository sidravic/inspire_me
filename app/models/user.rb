class User < ActiveRecord::Base
  acts_as_authentic
  validates_uniqueness_of :username
  validates_presence_of :username

  def activate
    transaction do
      self.activated = true
      self.reset_perishable_token
    end
  end
end
