require 'spec_helper'

module UserControllerSpecHelper
  def valid_attributes
   {   
    :username => "sid_#{Time.now.to_i}",
    :email => "sid.ravichandran_#{Time.now.to_i}@gmail.com",
    :password => "test123456",
    :password_confirmation => "test123456"
   }
  end
end


describe UsersController do
  before(:each) do
    @user = mock_model(User)
    User.stub!(:new).and_return(@user)
   
    @params = valid_attributes
  end


  def do_get
    get :new
  end
  
  it "should create a new user" do
    User.should_receive(:new).and_return(@user)
    do_get
  end

  it "should render the new user or registration page" do
    do_get
    response.should render_template("new")
  end
end

include UserControllerSpecHelper
describe UsersController, "handling POST /users" do
  
  before(:each) do
    #@user = User.new
    #@user.attributes = valid_attributes
    @params = valid_attributes
    user = User.new
    user.attributes = @params       
  end


  def do_post
    post :create
  end

  
  it "should create new user " do        
    count = User.count
    UserMailer.stub!(:deliver_activation_email)
    user = User.new(@params)
    UserObserver.stub!(:after_create).with(user)
    user.save.should eql(true)
    User.count.should eql(count + 1)
    
  end

  it "should render the success page on successful signup" do    
    UserMailer.stub!(:deliver_activation_email)
    post :create, :user => @params            
    response.should render_template("users/success")
  end

  it "should send email on successful signup" do
    pending
    post :create, :user => @params
    UserMailer.should_receive(:deliver_activation_email).with(:anything)
  end

  

  
end

describe UsersController, "handling GET /activate" do
  before(:each) do
    @user = User.new
    @user.attributes = valid_attributes
    @user.perishable_token = "123456789"    
    
  end

  it "should activate the user" do
    User.stub!(:find_by_perishable_token).with("123456789").and_return(@user)
    get :activate, :id => "123456789"
    @user.activated.should eql(true)
  end

  it "should redirect user to the dashboard" do
    User.stub!(:find_by_perishable_token).with("123456789").and_return(@user)
    get :activate, :id => "123456789"
    response.should redirect_to user_url(@user)
  end

  it "should reset perishable_token " do
    User.stub!(:find_by_perishable_token).with("123456789").and_return(@user)
    get :activate, :id => "123456789"
    @user.perishable_token.should_not eql("123456789")
  end

end
