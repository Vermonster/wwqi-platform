class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.text :details
      t.boolean :item_related, :default => false
      t.boolean :private, :default => false
      t.string :type
      t.references :creator

      t.timestamps
    end
  end
end
