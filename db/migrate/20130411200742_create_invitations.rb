class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.string :recipient_name
      t.string :recipient_email
      t.text :message
      t.references :post

      t.timestamps
    end
  end
end
