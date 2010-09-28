class WelcomeController < ApplicationController
  def index
  end

  def register
    @user = User.new
  end

end
