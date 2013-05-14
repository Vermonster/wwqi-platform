class ChangeItemable < ActiveRecord::Migration
  def up
    change_table :items do |t|
      t.remove :comment_id
      t.references :itemable, polymorphic: true
    end
  end

  def down
    change_table :items do |t|
      t.remove_references :itemable, polymorphic: true
      t.integer :comment_id
    end
  end
end
