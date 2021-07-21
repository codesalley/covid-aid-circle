class Donation < ApplicationRecord
    belongs_to :receiver, class_name: "User", foreign_key: "receiver_id"
    belongs_to :donor, class_name: "User", foreign_key: "donor_id"
    
end
