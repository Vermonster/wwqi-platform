class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :details
      t.references :commentable, polymorphic: true
      t.references :user

      t.timestamps
    end
  end
end
