class CollaborationMailer < ActionMailer::Base
  default from: ENV['MAILER_SENDER'] || '"Women\'s Worlds in Qajar Iran" <no-reply@qajarwomen.org>'

  def new_collaboration(collaborator)
    @post = collaborator.post
    @recipient = collaborator.user
    mail(to: @recipient.email, subject: "You've been invited by #{@post.creator.fullname} to collaborate on a project in the WWQI Research Platform")
  end

end
