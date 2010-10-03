class PostsController < ApplicationController
  def index
  end

  def new
    @post = Post.new    
  end

  def create    
    @post =  Post.new(params[:post])
    photo = Photo.new(params[:photo])
    @post.user = current_user
    @post.photos << photo    
    if @post.save
      flash[:notice] = "Your post has been successfully saved"
      redirect_to post_url(@post)
    else      
      render :action => "new"
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update    
    @post = Post.find(params[:id])
    photo = @post.photos.last
    if @post.update_post(params)
      flash[:notice] = "Your post has been successfully updated"      
      redirect_to post_url(@post)
    else           
      render :action => "edit"
    end
  end

  def destroy
    @post =  Post.find(params[:id])
    if @post.destroy
      flash[:notice] = "Your post was successfully removed"
      redirect_to user_posts_url(current_user)
    else
      flash[:notice] = "Something seems to have gone wrong. Give us some time to fix it. "
      redirect_to :back
    end
  end

end
