class RemoveAdminUserTable < ActiveRecord::Migration
  def change
    drop_table :admin_users
  end
end
