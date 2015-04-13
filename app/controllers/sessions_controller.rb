class SessionsController < ApplicationController
  def new
    
  end
  def create
    user = User.find_by_username(params[:user])

    if user && user.authenticate(params[:password])
      flash[:notice] = "Login Successful"
      session[:user_id] = user.id
      redirect_to root_path
    else
      flash[:notice] = "wrong password or user"
      render :new
    end
  end
  def destroy
    flash[:notice] = "#{current_user.username.capitalize} has logged out"
    session[:user_id] = nil
    redirect_to root_path
  end
end