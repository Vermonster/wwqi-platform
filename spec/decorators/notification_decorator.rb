require 'spec_helper'

describe NotificationDecorator do
  before do
    bob = create(:user, first_name: 'Bob')
    alice = create(:user, last_name: 'Smith', first_name: 'Alice')

    question = create(:question, creator: bob, title: 'My Question')
    discussion = create(:discussion, creator: bob, title: 'My Discussion')
    research = create(:research, creator: bob, title: 'My Research')
    contribution = create(:transcription, creator: bob, details: 'My Contribution')
    
    comment1 = create(:comment, commentable: question, user: alice)
    comment2 = create(:comment, commentable: discussion, user: alice)
    comment3 = create(:comment, commentable: research, user: alice)
    comment4 = create(:comment, commentable: contribution, user: alice)

    notification1 = create(:notification, user: bob, notifiable: comment1)
    notification2 = create(:notification, user: bob, notifiable: comment2)
    notification3 = create(:notification, user: bob, notifiable: comment3)
    notification4 = create(:notification, user: bob, notifiable: comment4)

    @n1_decorator = notification1.decorate
    @n2_decorator = notification2.decorate
    @n3_decorator = notification3.decorate
    @n4_decorator = notification4.decorate
  end

  it "has a message" do
    @n1_decorator.message.should == "Alice Smith replied to \"My Question\""
    @n2_decorator.message.should == "Alice Smith posted to \"My Discussion\""
    @n3_decorator.message.should == "Alice Smith commented on \"My Research\"" 
    # Randomly generated item has 'Not Found' as its name always
    @n4_decorator.message.should == "Alice Smith commented on your transcription for \"Not Found\""  
  end
end
