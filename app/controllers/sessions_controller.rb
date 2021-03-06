class SessionsController < ApplicationController
  
  def new
    @title = "login"
  end
  
  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id.to_s
      redirect_to root_url, :notice => "Logged in!"
    else
      flash.now.alert = "Invalid login"
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Logged out!"
  end
end
