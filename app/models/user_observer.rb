class UserObserver < ActiveRecord::Observer
  def after_create(user)        
    UserMailer.deliver_activation_email(user)
  end
end
