class AddDonationToUser < ActiveRecord::Migration[6.1]
  def change
    add_reference :donations, :donor, references: :users, index: true
    add_reference :donations, :receiver, references: :users, index: true

  end
end
