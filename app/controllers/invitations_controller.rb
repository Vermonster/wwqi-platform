class InvitationsController < ApplicationController
  def create
    @invitation = Invitation.new(params[:invitation])
    @invitation.inviter = current_user
    if @invitation.save
      InvitationMailer.invitation_email(@invitation).deliver
      redirect_to :back, notice: "The invitation has been sent."
    else
      render :new
    end
  end

  def show

  end

  def new
    @invitation = Invitation.new
  end
end
