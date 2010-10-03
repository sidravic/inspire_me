require 'spec_helper'

module PostSpecHelper
  def valid_attributes
    {
      :title => "My title"
    }
  end

  def valid_photo_attributes
    {
      :photo_title=>"This is the title",
      :photo_taken_with=>"",
      :image=>File.new("/Users/SIDDHARTH/Pictures/Photo Booth/Photo on 2010-07-21 at 11.40.jpg")
    }
  end

  def new_attributes
    {
      :photo => {:photo_title => "New Title"},
      :post => {:title => "New Post Title"}
    }
  end
end

describe Post do
  include PostSpecHelper
  before(:each) do
    @post = Post.new
    @post.attributes = valid_attributes.except(:title)
  end

  it "should have one error on title" do
    @post.should have(1).error_on(:title)
  end

  it "should update both post and photo info" do
    post = Post.new
    post.attributes = valid_attributes
    photo = Photo.new
    photo.attributes = valid_photo_attributes
    post.photos << photo
    post.update_post(new_attributes)
    post.title.should eql(new_attributes[:post][:title])
    post.photos.last.photo_title.should eql(new_attributes[:photo][:photo_title])
  end
end
