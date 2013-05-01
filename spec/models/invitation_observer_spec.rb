require 'spec_helper'

describe InvitationObserver do

  it 'sends all invitations when a post is create' do
    num = 4 # test with 4 invitations
    
    # Check all invitations are in the Mailer queue
    expect{ create(:post_with_invitations, number_of_invitations: num) }.to change{InvitationMailer.deliveries.length}.by num
    
    # Check the mailer sends the invitations
    InvitationMailer.perform_deliveries.should == true
  end

end
