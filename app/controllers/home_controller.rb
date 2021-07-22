class HomeController < ApplicationController
  before_action :authenticate_user

  def index
    @logData = []
    User.all.map do |user|
      if user.codinates.size > 0
        @logData << JSON.generate({
          lat: user.codinates[0],
          lng: user.codinates[1],
          donor: user.donor,
          user: user.first_name + " " + user.last_name,
          id: user.id,
        }) unless user.codinates.nil?
      end
    end
  end

  def user_profile
    @donations = current_user.donations
    p @donations
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

  private

  def donations_params
    params.permit(:receiver_id, :item, :amount)
  end
end
