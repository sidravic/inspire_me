class UserSessionsController < ApplicationController
  def login
    @user_session = UserSession.new
  end

  def create    
    user_session = UserSession.new(params[:user_session])    
    if user_session.save      
      redirect_to user_url(current_user)
    else      
      flash[:notice] = "#{user_session.errors.full_messages}"
      redirect_to :action => 'login'
    end
  end

  def logout    
    clear_session
    redirect_to root_url
  end

end
