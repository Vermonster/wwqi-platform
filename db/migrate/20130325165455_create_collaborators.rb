class CreateCollaborators < ActiveRecord::Migration
  def change
    create_table :collaborators do |t|
      t.integer :user_id
      t.belongs_to :post

      t.timestamps
    end
    add_index :collaborators, :post_id
  end
end
