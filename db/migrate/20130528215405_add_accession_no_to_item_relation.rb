class AddAccessionNoToItemRelation < ActiveRecord::Migration
  def up
    change_table :item_relations do |t|
      t.string :accession_no
    end
  end

  def down
    change_table :item_relations do |t|
      t.remove :accession_no
    end
  end
end
