class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :email
      t.string :phone_number
      t.string :address
      t.string :first_name
      t.string :last_name
      t.string :middle_name
      t.boolean :donor, default: false
      t.boolean :activated, default: false

      t.timestamps
    end
  end
end
