class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :url
      t.belongs_to :post

      t.timestamps
    end
    add_index :items, :post_id
  end
end
