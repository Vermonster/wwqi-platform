class ChangeItemIdToAscessionNo < ActiveRecord::Migration
  def change
    change_table :items do |t|
      t.rename :item_id, :accession_no
    end
  end
end
