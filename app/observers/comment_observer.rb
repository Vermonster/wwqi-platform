class CommentObserver < ActiveRecord::Observer
  def after_create(comment)
    comment.create_notification(user_id: comment.commentable_creator.id)
  end
end

