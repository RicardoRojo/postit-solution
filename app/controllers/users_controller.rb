class UsersController < ApplicationController

  before_action :set_user, only: [:show,:edit,:update]
  before_action :user_editable, only:[:edit]

  def show
    
  end

  def new
    @user = User.new
  end
  def create
    @user = User.new(user_params)

    if @user.save
      flash[:notice] = "User created. Welcome #{@user.username.capitalize}!"
      session[:user_id] = @user.id
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
    
  end

  def update

    if @user.update(user_params)
      flash[:notice] = "User updated"
      redirect_to user_path(current_user)
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:username,:password)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def user_editable
    if current_user != @user
      flash[:error] = "The user cannot be edited"
      redirect_to user_path(current_user)
    end
  end
end