class CreateUploads < ActiveRecord::Migration
  def change
    create_table :uploads do |t|
      t.string :content
      t.references :uploadable, polymorphic: true
      
      t.timestamps
    end
  end
end
