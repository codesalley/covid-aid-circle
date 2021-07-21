class UpadateUserModel < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :password
    remove_column :users, :password_confirmation
    add_column :users, :password_digest, :string
    #Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
  end
end
