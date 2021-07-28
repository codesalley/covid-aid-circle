class Chat < ApplicationRecord
  belongs_to :sender, class_name: "User", foreign_key: "sender_id", inverse_of: :sent_chats
  belongs_to :receiver, class_name: "User", foreign_key: "receiver_id", inverse_of: :received_chats
  has_many :messages, class_name: "Message", dependent: :destroy
end
