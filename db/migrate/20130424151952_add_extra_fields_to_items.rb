class AddExtraFieldsToItems < ActiveRecord::Migration
  def change
    change_table :items do |t|
      t.string :thumbnail
      t.integer :item_id
    end
  end
end
