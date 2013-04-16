class InvitationMailer < ActionMailer::Base
  default from: "info@example.com"

  def invitation_email(invitation)
    @invitation = invitation
    mail(to: invitation.recipient_email, subject: 'Invitation from WWQI')
  end
end
