class AddCommentAssociationToItem < ActiveRecord::Migration
  def change
    add_column :items, :comment_id, :integer, references: :comments
  end
end
