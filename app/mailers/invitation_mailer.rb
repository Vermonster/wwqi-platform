class InvitationMailer < ActionMailer::Base
  default from: ENV['MAILER_SENDER'] || '"Women\'s Worlds in Qajar Iran" <no-reply@qajarwomen.org>'

  def new_invitation(invitation)
    @invitation = invitation
    mail(to: invitation.recipient_email, subject: 'Collaborate on the WWQI Research Platform!')
  end
end
