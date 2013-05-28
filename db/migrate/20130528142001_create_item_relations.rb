class CreateItemRelations < ActiveRecord::Migration
  def change
    create_table :item_relations do |t|
      t.references :item
      t.references :itemable, polymorphic: true
      t.timestamps
    end
  end
end
