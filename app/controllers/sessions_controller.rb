class SessionsController < ApplicationController
  def create
    user = user.find_by_email(params[:email])
    if user && user.authenticate(params[:email])
      session[:user_id] = user.id
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
