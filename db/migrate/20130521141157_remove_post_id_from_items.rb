class RemovePostIdFromItems < ActiveRecord::Migration
  def up
    change_table :items do |t|
      t.remove :post_id
    end
  end

  def down
    change_table :items do |t|
      t.references :post
    end
  end
end
