require 'spec_helper'

module PostsControllerSpecHelper
  def valid_photo_attributes    
    {
      :photo_title=>"Photo Title",
      :photo_taken_with=>"Cannon",
      'photo_taken_on(1i)'=> "2010",
      'photo_taken_on(2i)' => "10",
      'photo_taken_on(3i)' => "2",
      :image=>File.new("/Users/SIDDHARTH/Pictures/Photo Booth/Photo on 2010-07-21 at 11.40.jpg")
    }
  end

  def valid_post_attributes
    {
      :title=>"Post Title"
    }
  end
end

describe PostsController, "/GET new" do
    before(:each) do
      @post =  mock_model(Post)
      @photo = mock_model(Photo)
    end
    
    it "should render the upload photo page" do
      
      get :new
      response.should render_template("new")
    end  
    
  end

include PostsControllerSpecHelper
describe PostsController, "/POST create " do
    before(:each) do      
      @user = mock_model(User)
    end

    it "should create a new photo and a new post" do
      controller.should_receive(:current_user).and_return(mock_model(User))
      post_count = Post.count
      photo_count = Photo.count
      get :create, :photo => valid_photo_attributes, :post => valid_post_attributes      
      Post.count.should eql(post_count + 1)
      Photo.count.should eql(photo_count + 1)
    end

  it "should send the user to the show page on success" do
      controller.should_receive(:current_user).and_return(@user)      
      get :create, :photo => valid_photo_attributes , :post => valid_post_attributes
      response.should redirect_to(post_url(Post.last.id))
  end

  end


describe PostsController, "/GET edit " do
    before(:each) do
      @user = mock_model(User)
      Post.stub!(:find).and_return(mock_model(Post))
    end

  it "should render the edit page" do
    get :edit
    response.should render_template("edit")
  end

end

describe PostsController, "/PUT update " do
    before(:each) do
      @post = mock_model(Post, :photos =>[mock_model(Photo)])
      Post.stub!(:find).and_return(@post)      
    end

  it "should render the edit page" do
    @post.should_receive(:update_post).and_return(true)
    put :update, :id => 1, :post => {:title => "New Post Title" }, :photo => {:photo => "New Photo Title"}    
  end

  it "should render the show page on successful updation" do
    @post.should_receive(:update_post).and_return(true)
    put :update, :id => 1, :post => {:title => "New Post Title" }, :photo => {:photo => "New Photo Title"}    
    response.should redirect_to post_url(@post)
  end

end


describe PostsController, "/DELETE destroy " do
    before(:each) do
      Post.create!(:title => 'test1')
      Post.create!(:title => 'test2')
      @post = Post.create!(:title => 'test333')            
      @user = User.last
      controller.stub!(:current_user).and_return(@user)
    end

  it "should remove the post " do
    last_post = Post.last
    delete :destroy, :id => last_post.id
    Post.last.should_not eql(last_post)
  end


end

