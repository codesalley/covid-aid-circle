class CreateBanks < ActiveRecord::Migration[6.1]
  def change
    create_table :banks do |t|
      t.string :bank_name
      t.string :user_name
      t.string :account_number
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
