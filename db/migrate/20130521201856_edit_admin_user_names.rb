class EditAdminUserNames < ActiveRecord::Migration
  def change
    change_column :admin_users, :first_name, :string, :null => false
    change_column :admin_users, :last_name, :string, :null => false
  end
end
