class NotificationDecorator < Draper::Decorator
  delegate_all

  def link
    h.link_to message, target_path
  end
  
  def message
    "#{notifiable.user.first_name} #{action} \"#{target.title}\""
  end

  def target
    notifiable.commentable
  end

  def action
    case target
    when Question
      'replied to'
    when Discussion
      'posted to'
    when Research
      'commented on'
    end
  end

  def target_path
    case target
    when Question, Discussion
      h.post_path(target)
    when Research
      h.research_path(target)
    end
  end
end
