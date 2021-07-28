class AddColumsToUserInverse < ActiveRecord::Migration[6.1]
  def change
    add_reference :chats, :receiver, references: :users, index: true
    add_reference :chats, :sender, references: :users, index: true
    add_column :donations, :confirmed, :boolean, :default => false
    #Ex:- :default =>''
    #Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
  end
end
