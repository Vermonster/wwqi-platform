class NotificationDecorator < Draper::Decorator
  delegate_all

  def link
    h.link_to message, h.user_notification_path(h.current_user, model)
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
end
