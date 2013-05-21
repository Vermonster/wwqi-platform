class MissingIndexes < ActiveRecord::Migration
  def change
    add_index "collaborators", ["user_id"], :name => "index_collaborators_on_user_id"
    add_index "comments", ["user_id"], :name => "index_comments_on_user_id"
    add_index "comments", ["commentable_id", "commentable_type"], :name => "index_comments_on_commentable_id_and_commentable_type"
    add_index "contributions", ["creator_id"], :name => "index_contributions_on_creator_id"
    add_index "followings", ["user_id"], :name => "index_followings_on_user_id"
    add_index "items", ["itemable_id", "itemable_type"], :name => "index_items_on_itemable_id_and_itemable_type"
    add_index "notifications", ["user_id"], :name => "index_notifications_on_user_id"
    add_index "posts", ["creator_id"], :name => "index_posts_on_creator_id"
    add_index "uploads", ["uploadable_id", "uploadable_type"], :name => "index_uploads_on_uploadable_id_and_uploadable_type"
  end
end
