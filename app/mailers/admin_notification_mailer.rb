class AdminNotificationMailer < ActionMailer::Base
  FROM = ENV['MAILER_SENDER'] || '"Women\'s Worlds in Qajar Iran" <no-reply@qajarwomen.org>'
  TO = ENV['ADMIN_NOTIFICATION_EMAIL']

  default from: FROM

  def new_post(post)
    @post = post
    mail(to: TO, subject: "New WWQI user platform post by #{@post.creator.try(:email)}: #{@post.title}")
  end

  def new_contribution(contribution)
    @contribution = contribution
    if contribution.type == 'Correction'
      mail(to: TO, subject: "New WWQI user platform correction")
    else
      mail(to: TO, subject: "New WWQI user platform #{@contribution.type} by #{@contribution.creator.try(:email)}")
    end
  end
end
