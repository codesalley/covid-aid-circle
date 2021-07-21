class AddLogAndLanToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :codinates, :text, array: true, default: []
    #Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
  end
end
