class Chat < ApplicationRecord
  belongs_to :user
  has_many :messages, class_name: "message"
end
