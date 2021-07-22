class User < ApplicationRecord
  after_create :set_sms_code
  validates_presence_of :first_name, on: :create, message: "can't be blank"
  validates_presence_of :last_name, on: :create, message: "can't be blank"
  validates_presence_of :address, on: :create, message: "can't be blank"
  validates_presence_of :password, on: :create, message: "can't be blank"
  validates_presence_of :phone_number, on: :create, message: "can't be blank"

  has_secure_password

  has_many :donations, class_name: "Donation", foreign_key: "donor_id", dependent: :destroy
  has_many :received_donations, class_name: "Donation", foreign_key: "receiver_id", dependent: :destroy
  has_many :chats, class_name: "Chat", dependent: :destroy
  has_many :messages, class_name: "Message", dependent: :destroy

  private

  def set_sms_code
    code = Random.rand(1012..9292)
    self.tmp_code = code
  end
end
