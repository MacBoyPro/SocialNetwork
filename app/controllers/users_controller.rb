class UsersController < ApplicationController

  before_filter :authenticate_user!

  def index
    @users = User.all.to_a
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    user = User.find(params[:id])
    if user.id == current_user.id
      @user = user
    else
      render status: :forbidden
    end
  end

  def update
    user = User.find(params[:id])
    if user.id == current_user.id
      params[:user].each {|key, value| user.send("#{key.to_s}=", value) }
      user.save
      redirect_to user_path(user)
    else
      render :edit, status: :forbidden
    end
  end

  def follow
    @user = User.find(params[:id])
    current_user.followed_users << @user
    redirect_to @user
  end
end