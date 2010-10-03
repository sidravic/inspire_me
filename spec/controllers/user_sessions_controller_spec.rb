require 'spec_helper'

module UserSessionSpecHelper
  def valid_attributes
    {
      
      :email => "sid@trashmail.com",
      :password => "abcabcabc"
      
    }
  end
end

include UserSessionSpecHelper
describe UserSessionsController, "GET /login" do  
  it "should render login page" do
    get :login
    response.should render_template("login")
  end
end

describe UserSessionsController, "POST /create" do

  it "should add the user to the session" do
    get :create, :user_session => valid_attributes
    current_user_session = UserSession.find
    current_user_session.record.should eql(User.find_by_email('sid@trashmail.com'))
  end

  it "should redirect the user to the dashboard" do
    get :create, :user_session => valid_attributes
    response.should redirect_to user_url(User.find_by_email('sid@trashmail.com'))
  end

end


describe UserSessionsController, "POST /destroy" do

  it "should remove the user from the session" do
    get :logout
    UserSession.find.should eql(nil)
  end

  it "should redirect user to the root url" do
    get :logout
    response.should redirect_to root_url
  end


end
