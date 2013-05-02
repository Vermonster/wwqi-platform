class InvitationObserver < ActiveRecord::Observer
  def after_create(invitation)
    InvitationMailer.new_invitation(invitation).deliver
  end
end
