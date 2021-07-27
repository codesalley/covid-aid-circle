class HomeController < ApplicationController
  before_action :authenticate_user
  before_action :authenticate_account

  def index
    @logData = get_codinates
  end

  def user_profile
    @donations = current_user.donations
  end

  def donations
    @user = User.find_by(id: params[:id])
  end

  def confirm_donations
    donation = current_user.donations.build(donations_params)
    p donation
    if donation.save
      redirect_to profile_path, notice: "Donation Sent"
    else
      redirect_to profile_path, alert: "Try again later"
    end
  end

  def remove_email
    current_user.update(email: nil)
    redirect_to profile_path
  end

  def add_email
    email = params[:email]
    current_user.update(email: email)
    send_email(email, current_user.first_name)
  end

  private

  def donations_params
    params.permit(:receiver_id, :item, :amount)
  end
end
