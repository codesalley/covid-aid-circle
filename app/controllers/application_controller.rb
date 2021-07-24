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

  def get_codinates
    logData = []
    User.all.map do |user|
      if user.codinates.size > 0
        logData << JSON.generate({
          lat: user.codinates[0],
          lng: user.codinates[1],
          donor: user.donor,
          user: user.first_name.capitalize + " " + user.last_name,
          id: user.id,
        }) unless user.codinates.nil?
      end
    end
    logData
  end
end
