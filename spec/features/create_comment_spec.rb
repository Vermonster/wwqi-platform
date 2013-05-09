require 'spec_helper'

describe 'comment creation' do
  describe 'without authentication' do
    let!(:question) { create(:question) }
    
    it 'only allows a signed in user to create a new post' do
      visit post_path(question)
      page.should have_content("You have to sign in to comment.")
    end
  end

  describe 'submit a comment for a question' do
    let!(:question) { create(:question) }
    let!(:user) { create(:user) }

    before(:each) { sign_in(user) }
    after(:each) { sign_out }
    
    it 'creates a new comment and redirects back to the parent page' do
      visit post_path(question)
      
      within('.comment-box') do
        fill_in 'comment_details', with: 'squirrel'
        click_on 'Submit answer'
      end

      Comment.count.should == 1
      
      current_path.should == post_path(question)

      within('.comments') do
        page.should have_content("#{user.fullname} replied")
        page.should have_content("squirrel")
      end
    end
  end

  describe 'comment notifications' do
    let!(:user) { create(:user) }
    let!(:follower1) { create(:user) }
    let!(:follower2) { create(:user) }
    let!(:question) { create(:question) }

    before(:each) { sign_in(user) }
    after(:each) { sign_out }

    it 'creates a notification for each follower' do
      create(:following, followable: question, user: user)
      create(:following, followable: question, user: follower1)
      create(:following, followable: question, user: follower2)

      visit post_path(question)
      
      within('.comment-box') do
        fill_in 'comment_details', with: 'squirrel'
        click_on 'Submit answer'
      end

      user.notifications.count.should == 0
      follower1.notifications.count.should == 1
      follower2.notifications.count.should == 1
    end
  end
end
