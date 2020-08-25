module Admin
  class SessionsController < ApplicationController
    def new; end

    def create
      user = User.find_by(user_params[:user_id])

      if user&.authenticate(user_params[:password])
        session[:user_id] = user.id
        redirect_to admin_new_post_path
      else
        redirect_to admin_login_path
      end
    end

    def destroy
      session[:user_id] = nil
      redirect_to posts_path
    end

    private

    def user_params
      params.permit(:user_id, :password)
    end
  end
end
