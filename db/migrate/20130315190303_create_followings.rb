class CreateFollowings < ActiveRecord::Migration
  def change
    create_table :followings do |t|
      t.references :user
      t.references :followable, polymorphic: true

      t.timestamps
    end
  end
end
