class UpdateContributions < ActiveRecord::Migration
  def up
    change_table :contributions do |t|
      t.remove :item_id
      t.change :details, :text
    end
  end

  def down
    change_table :contributions do |t|
      t.references :item
      t.change :details, :string
    end
  end
end
