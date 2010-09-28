class UserMailer < ActionMailer::Base
  
  def activation_email(user)    
    from "registration@InspireMe.com"
    recipients user.email
    subject "Registration Success- Welcome to InspireMe.com"
    sent_on Time.zone.now
    content_type "text/html"
    body :user => user
  end
end
