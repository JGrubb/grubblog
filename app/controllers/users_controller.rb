class UsersController < ApplicationController
  before_filter :current_user
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
  
end