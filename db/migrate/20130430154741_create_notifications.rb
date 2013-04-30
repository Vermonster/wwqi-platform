class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.boolean :unread, default: true
      t.references :user
      t.references :notifiable, polymorphic: true

      t.timestamps
    end
  end
end
