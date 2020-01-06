class SessionsController < ApplicationController
  def create
    user = User.find_by(params[:user_id])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to new_post_path
    else
      redirect_to sessions_path
    end
  end
end
