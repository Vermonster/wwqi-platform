class ContributionDecorator < Draper::Decorator
  delegate_all
  decorates_association :comments

  def created_ago
    "#{h.time_ago_in_words(created_at)} ago" 
  end

  def comments_size
    if comments_count.zero?
      "no #{comment_key.pluralize}"
    else
      h.pluralize(comments_count, comment_key)
    end
  end

  def comment_key
    "comments"
  end
  
  def title_link
    h.link_to title, h.contribution_path(model)
  end
  
  def title
    item.name
  end
end
