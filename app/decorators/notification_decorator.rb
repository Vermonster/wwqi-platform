class NotificationDecorator < Draper::Decorator
  delegate_all

  def link
    h.link_to message, h.user_notification_path(h.current_user, model)
  end
  
  def message
    "#{user.fullname} #{action} \"#{target.title}\""
  end

  def user
    notifiable.user
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
    when Contribution
      "commented on your #{target.type.downcase} for"
    end
  end
end
