require File.expand_path(File.dirname(__FILE__)) + "/../spec_helper"

describe User do
  before(:each) do
    @valid_attributes = {
      :username => "sid_",
      :first_name => "Siddharth",
      :last_name => "Ravichandran",
      :email => "sid.ravichandran@gmail.com",
      :password => "test",
      :password_confirmation => "test"
    }

    @user_stub = User.new
    @user_stub.attributes = @valid_attributes    
  end

  it "should throw 1 error on a non-unique username" do
    @user = User.new
    @user.attributes = @valid_attributes.except(:username)
    @user.should have(3).error_on(:username)
  end

   it "should activate and reset perishable token" do
     @user = User.new
     @user.attributes = @valid_attributes
     @user.perishable_token = "123456789"     
     @user.activate
     @user.activated.should eql(true)
     @user.perishable_token.should_not eql("123456789")
   end
  

  
    
  
end
