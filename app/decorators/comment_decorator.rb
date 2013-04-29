class CommentDecorator < Draper::Decorator
  delegate_all

  def header
    "#{user.first_name} #{header_key}"
  end

  def header_key
    case commentable
    when Question
      'replied'
    when Discussion
      'replied'
    end
  end

  def created_ago
    "#{h.time_ago_in_words(created_at)} ago"
  end
end
