class CommentObserver < ActiveRecord::Observer
  def after_create(comment)
    comment.notifications.create(user_id: comment.commentable_creator.id)

    comment.commentable.followings.each do |f|
      comment.notifications.create(user_id: f.user.id) unless f.user == comment.user
    end
  end
end
