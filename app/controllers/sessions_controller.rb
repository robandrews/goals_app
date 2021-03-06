class SessionsController < ApplicationController

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.find_by_credentials(
            params[:user][:password],
            params[:user][:username])
    if @user
      sign_in!(@user)
      redirect_to @user
    else
      flash[:errors] = ["Sign In Failed"]
      redirect_to new_session_url
    end
  end

  def destroy
    sign_out
    redirect_to new_session_url
  end
end
