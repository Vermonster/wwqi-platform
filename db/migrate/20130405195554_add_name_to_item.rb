class AddNameToItem < ActiveRecord::Migration
  def change
    change_table :items do |t|
      t.string :name
    end
  end
end
