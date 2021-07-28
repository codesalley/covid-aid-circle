class ApplicationController < ActionController::Base
  require "sendgrid-ruby"
  include SendGrid

  # &message=xxxxxx&mobile=9999999999&sender=xxxxxxx&type=1
  URL = "http://www.bulksms2u.com/websmsapi/ISendSMS.aspx?username=#{ENV["SMS_USERNAME"]}&password=#{ENV["SMS_PASSWORD"]}"

  def authenticate_user
    user = User.find_by(id: session[:user_id])
    if !user
      redirect_to home_path
    end
  end

  def authenticate_account
    user = User.find_by(id: session[:user_id])
    if user && !user.verified
      redirect_to welcome_path
    end
  end

  def current_user
    user = User.find_by(id: session[:user_id])
    user
  end

  def get_codinates
    logData = []
    User.all.map do |user|
      if user.codinates.size > 0 && user.id != current_user.id
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

  def newCodinates
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

  def send_sms(number, tmp_code)
    phone_number = number
    newurl = URL + "&message=Your verification code is #{tmp_code}&mobile=+#{phone_number}&sender=kitajagakita&type=1"

    res = HTTParty.get(newurl)
  end

  def send_email(email, first_name)
    from = SendGrid::Email.new(email: ENV["SENDER_EMAIL"])
    to = SendGrid::Email.new(email: email)
    subject = "Welcome to kitajagakita"
    content = SendGrid::Content.new(type: "text/plain", value: "#{first_name}, #{email}, added to your account")
    mail = SendGrid::Mail.new(from, subject, to, content)
    sg = SendGrid::API.new(api_key: ENV["SENDGRID_API_KEY"])
    response = sg.client.mail._("send").post(request_body: mail.to_json)
    p response
  end
end
