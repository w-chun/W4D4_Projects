class SessionsController < ApplicationController
  def new
    render :new
  end

  def create
    user = User.find_by_credentials(
            params[:user][:username],
            params[:user][:password]
    )
    if user.nil?
      flash.now[:errors] = ["Invalid username or password"]
      render :new
    else
      user.reset_session_token!
      login!(user)
      redirect_to cats_url
    end

  end

  def destroy
    logout
    redirect_to cats_url
  end
end
