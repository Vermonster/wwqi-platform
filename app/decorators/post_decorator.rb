class PostDecorator < Draper::Decorator
  delegate_all

  def created_ago
    "#{h.time_ago_in_words(created_at)} ago" 
  end

  def comments_received
    if comments_count.zero?
      "no #{comment_key.pluralize}"
    else
      h.pluralize(comments_count, comment_key)
    end
  end
end
