class CommentDecorator < Draper::Decorator
  delegate_all

  def header
    "#{user.fullname} #{header_key}"
  end

  def header_key
    case commentable
    when Question, Discussion, Research
      'replied'
    when Contribution
      'commented'
    end
  end

  def created_ago
    "#{h.time_ago_in_words(created_at)} ago"
  end
end
