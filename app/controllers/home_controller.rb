class HomeController < ApplicationController
  before_action :authenticate_user, except: :landing_page
  before_action :authenticate_account, except: :landing_page

  def index
    @logData = get_codinates
  end

  def landing_page
    @logData = newCodinates
  end

  def add_bank
    bank = Bank.create(user_id: current_user.id, account_number: params[:account_number], bank_name: params[:bank_name], user_name: params[:user_name])

    if bank.save
      current_user.update(activated: true)
      redirect_to profile_path, notice: "account Added"
    else
      redirect_to root_path, alert: "Try again later"
    end
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
