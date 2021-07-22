class SessionsController < ApplicationController
  before_action :authenticate_user, only: [:welome, :verify_code]

  # gets signup page and create new user GET / POST
  def signup
    @user = User.new
  end

  def new_session
    user = User.create(user_params)
    p user
    if user.save
      session[:user_id] = user.id
      ip = request.location
      user.update(codinates: ip.data["loc"].split(","))
      redirect_to welcome_path, notice: "welcome, verify account to get connected"
    else
      render :signup
    end
  end

  # gets welcome page to allow users verify phone numbers before continuing

  def welcome
  end

  def verify_code
    if current_user.tmp_code === params[:confirmation_code]
      current_user.update(activated: true)
      redirect_to root_path, notice: "account activated"
    else
      flash[:alert] = "invalid code"
      render :welcome
    end
  end

  # login sessions gets and post

  def login_user
  end

  def new_auth
    user = User.find_by(phone_number: params[:phone_number])

    if user.present? && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_path
    else
      flash[:alert] = "invalid credentails"
      render :login_user
    end
    p params
  end

  # logout user
  def logout
    session[:user_id] = nil
    redirect_to registration_path
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :middle_name, :address, :phone_number, :password, :password_confirmation, :donor)
  end
end
