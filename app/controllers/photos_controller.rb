class PhotosController < ApplicationController
  def new
    @photo =  Photo.new    
  end

  def index
    @photo = Photo.new
    render :action => "new"
  end

  def create
    @photo = Photo.new(params[:photo])    
    if @photo.save
      flash[:notice] = "Your Photo was successfully uploaded"
      render :action => "show"
    else
      render :action => "new"
    end
  end

  def show
    @user = current_user
  @photo = Photo.find(params[:id])
  end

  def destroy
    @user = current_user
    @photo = Photo.find(params[:id])
    if @photo.destroy
      flash[:notice] = "Your photo has been successfully deleted"
      redirect_to user_url(current_user)
    else
      flash[:notice] = "Oops something seems to have gone wrong. Give it another go in a few minutes"
      redirect_to :back
    end
  end
end
