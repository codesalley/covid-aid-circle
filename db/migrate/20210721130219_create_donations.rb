class CreateDonations < ActiveRecord::Migration[6.1]
  def change
    create_table :donations do |t|
      t.string :item
      t.string :amount

      t.timestamps
    end
  end
end
