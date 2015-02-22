class AdminNotificationMailer < ActionMailer::Base
  default from: ENV['MAILER_SENDER'] || '"Women\'s Worlds in Qajar Iran" <no-reply@qajarwomen.org>'

  def new_post(post)
    @post = post
    mail(to: ENV['ADMIN_NOTIFICATION_EMAIL'], subject: "New WWQI user platform post by #{@post.creator.try(:email)}: #{@post.title}")
  end
end
