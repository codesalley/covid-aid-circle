class User < ApplicationRecord
    has_secure_password
    
    has_many :donations, class_name: "Donation", foreign_key: "donor_id", dependent: :destroy
    has_many :received_donations, class_name: "Donation", foreign_key: "receiver_id", dependent: :destroy
  end
  