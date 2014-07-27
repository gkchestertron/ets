class SessionsController < ApplicationController
    before_action :admin_user, except: [:create, :destroy]
  def create
      @user = User.find_by_username(session_params[:username])
      if @user && @user.authenticate(session_params[:password])
        login!(@user)
      end
      redirect_to root_url
  end

  def destroy
      logout!
      redirect_to root_url
  end

  private

  def session_params
      params.require(:session).permit(:username, :password);
  end
end
