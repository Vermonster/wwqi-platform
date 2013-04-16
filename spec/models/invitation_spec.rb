require 'spec_helper'

describe Invitation do
  it { should belong_to(:inviter).class_name(:User) }
  it { should validate_presence_of :inviter_id }
  it { should validate_presence_of :recipient_email}

  it "has a valid factory" do 
    build(:invitation).should be_valid
  end

  context 'when it sends an invitation email' do
    let(:new_invitation) { FactoryGirl.build(:invitation) }
    let(:email) { InvitationMailer.invitation_email(new_invitation).deliver }

    it 'has a recipient email address' do
      email.to.should == [new_invitation.recipient_email]
    end

    it 'has a from email adddress' do
      email.from.should == ['info@example.com']
    end

    it 'has a subject' do
      email.subject.should include('Invitation')
    end

    it 'has an invitation message' do
      email.body.encoded.should match(new_invitation.inviter_fullname)
      email.body.encoded.should match("http://www.example.com/signup") 
    end
  end
end
