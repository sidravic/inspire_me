class UsersController < ApplicationController
  def index
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])    
    if @user.save      
      render :action => "success"
    else      
      render :action => "new"
    end
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def activate
    @user = User.find_by_perishable_token(params[:id])
    if @user
      @user.activate
      if @user.save
        flash[:notice] = "Awesome! Your account has been activated."
        redirect_to user_url(@user)
      else
        flash[:notice] = "Your token appears to invalid"
        redirect_to root_url
      end
    else
      flash[:error] = "Invalid token"
      redirect_to root_url
    end
  end

end
