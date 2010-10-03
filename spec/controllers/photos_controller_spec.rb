require 'spec_helper'

module PhotoControllerSpecHelper
  def valid_attributes
    { :photo_title=>"This is the title",
      :photo_taken_with=>"",
      :image=>File.new("/Users/SIDDHARTH/Pictures/Photo Booth/Photo on 2010-07-21 at 11.40.jpg")                 
     }
      
  end
end

include PhotoControllerSpecHelper
describe PhotosController, "GET /new" do


  #Delete this example and add some real ones
  it "should render the new photo upload page" do
    get :new
    response.should render_template("new")
  end
end


describe PhotosController, "GET /create" do

  before(:each) do
    #ApplicationController.class_eval{ @current_user = User.last }
    @user = mock_model(User)    
  end
  
  #Delete this example and add some real ones
  it "should create a new photo" do
    #controller.should_receive(:current_user).and_return(@user)
    count = Photo.all.size
    post :create, :photo => valid_attributes
    Photo.all.size.should_not eql(count)   
  end

  it "should send the user to the show page" do
    post :create, :photo => valid_attributes
    response.should render_template("show")
  end
end


describe PhotosController, "GET /index" do
  it "should lead the user to the new photo upload page" do
    get :index
    response.should render_template("new")
  end
end

