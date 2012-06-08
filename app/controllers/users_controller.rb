class UsersController < ApplicationController
  before_filter :require_user
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to root_url, :notice => "welcome!"
    else
      render "new"
    end
  end
  
  def show
    @user = User.find_by_id(params[:id])
  end
  
  private
  
  def require_user
    unless logged_in?
      flash[:error] = "Sorry jack.  You gotta be an admin to do that."
      redirect_to root_url
    end
  end
  
  def logged_in?
    !!current_user
  end
  
end