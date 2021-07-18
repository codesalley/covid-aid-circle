class AdaPhoneToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :phone_number, :string
    add_column :users, :active, :boolean, default: false
    add_column :users, :donor, :boolean, default: false

    #Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
  end
end
