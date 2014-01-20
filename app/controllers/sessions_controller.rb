class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(phone: params[:phone])

    if user && user.authenticate(params[:password])
      log_in!(user)
      redirect_to edit_user_path(user)
    else
      redirect_to new_user_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end