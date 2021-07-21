class ApplicationController < ActionController::Base
  def authenticate_user
    user = User.find_by(id: session[:user_id])
    if !user 
      redirect_to registration_path
    end
  end

  def current_user
    user = User.find_by(id: session[:user_id])
    user
  end
end
