class RemoveItemableFieldsFromItem < ActiveRecord::Migration
  def up
    change_table :items do |t|
      t.remove :itemable_id
      t.remove :itemable_type
    end
  end

  def down
    change_table :items do |t|
      t.integer :itemable_id
      t.string :itemable_type
    end
  end
end
