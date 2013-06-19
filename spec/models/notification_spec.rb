require 'spec_helper'

describe Notification do
  it { should belong_to(:user) }
  it { should belong_to(:notifiable) }
  it { should have_db_column(:unread) }

  it 'has a valid factory' do
    build(:notification).should be_valid
  end

  describe 'creation' do
    let(:user) { create(:user) }
    let(:question) { create(:question, creator: user) }
    let(:contribution) { create(:contribution, creator: user) }
    
    it 'is created after a comment is made' do
      comment = create(:comment, commentable: question)
      user.notifications.size.should == 1
      n = user.notifications.last
      n.notifiable.should == comment
    end

    it 'is created after a comment it made on contribution' do
      comment = create(:comment, commentable: contribution)
      user.notifications.size.should == 1
      n = user.notifications.last
      n.notifiable.should == comment
    end
  end

  describe 'unread' do
    let(:notification) { create(:notification) }

    it 'is unread upon creation' do
      notification.should be_unread
    end

    it 'can be set to read' do
      notification.read!
      notification.should_not be_unread
    end
  end
end
