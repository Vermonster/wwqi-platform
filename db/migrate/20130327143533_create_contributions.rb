class CreateContributions < ActiveRecord::Migration
  def change
    create_table :contributions do |t|
      t.string :details
      t.string :type
      t.references :item
      t.references :creator

      t.timestamps
    end
  end
end
