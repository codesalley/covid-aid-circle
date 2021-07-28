class Bank < ApplicationRecord
  validates_presence_of :bank_name, on: :create, message: "can't be blank"
  validates_presence_of :user_name, on: :create, message: "can't be blank"
  validates_presence_of :account_number, on: :create, message: "can't be blank"

  belongs_to :user, class_name: "User", foreign_key: "user_id"
end
