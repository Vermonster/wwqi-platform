require 'spec_helper'

describe Invitation do
  it { should belong_to(:post) }
  it { should validate_presence_of :recipient_email}

  it "has a valid factory" do 
    build(:invitation).should be_valid
  end

  context 'when it sends an invitation email' do
    let(:new_invitation) { FactoryGirl.build(:invitation) }
    let(:email) { InvitationMailer.new_invitation(new_invitation).deliver }

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
      email.body.encoded.should match(new_invitation.post_creator_fullname)
      email.body.encoded.should match(new_invitation.post_title)
      email.body.encoded.should match("http://www.qajarwomen.org/signup") 
    end

    it 'has a token' do 
      email.body.encoded.should match("http://www.qajarwomen.org/users/sign_up/#{new_invitation.token}")
    end
  end
end
