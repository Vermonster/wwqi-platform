class CommentObserver < ActiveRecord::Observer
  def after_create(comment)
    unless comment.user == creator.commentable.creator
      comment.notifications.create(user_id: comment.commentable_creator.id)
    end
  
    comment.commentable.followings.each do |f|
      comment.notifications.create(user_id: f.user.id) unless f.user == comment.user
    end
  end
end
