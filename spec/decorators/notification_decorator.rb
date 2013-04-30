require 'spec_helper'

describe NotificationDecorator do
  before do
    bob = create(:user, first_name: 'Bob')
    alice = create(:user, first_name: 'Alice')

    question = create(:question, creator: bob, title: 'My Question')
    discussion = create(:discussion, creator: bob, title: 'My Discussion')
    research = create(:research, creator: bob, title: 'My Research')
    
    comment1 = create(:comment, commentable: question, user: alice)
    comment2 = create(:comment, commentable: discussion, user: alice)
    comment3 = create(:comment, commentable: research, user: alice)

    notification1 = create(:notification, user: bob, notifiable: comment1)
    notification2 = create(:notification, user: bob, notifiable: comment2)
    notification3 = create(:notification, user: bob, notifiable: comment3)
    
    @n1_decorator = notification1.decorate
    @n2_decorator = notification2.decorate
    @n3_decorator = notification3.decorate
  end

  it "has a message" do
    @n1_decorator.message.should == "Alice replied to \"My Question\""
    @n2_decorator.message.should == "Alice posted to \"My Discussion\""
    @n3_decorator.message.should == "Alice commented on \"My Research\""
  end
end
