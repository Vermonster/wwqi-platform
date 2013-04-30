require 'spec_helper'

describe 'comment creation' do
  describe 'without authentication' do
    let!(:question) { create(:question) }
    
    it 'only allows a signed in user to create a new post' do
      visit posts_path
      click_on question.title
      page.should have_content("You have to login to comment.")
    end
  end

  describe 'submit a comment for a question' do
    let!(:question) { create(:question) }
    let!(:user) { create(:user) }

    before(:each) { sign_in(user) }
    after(:each) { sign_out }
    
    it 'creates a new comment and redirects back to the parent page' do
      visit '/'
      visit posts_path
      click_on question.title
      
      within('.comment-box') do
        fill_in 'comment_details', with: 'squirrel'
        click_on 'Submit answer'
      end

      Comment.count.should == 1
      
      current_path.should == post_path(question)

      within('.comments') do
        page.should have_content("#{user.first_name} replied")
        page.should have_content("squirrel")
      end
    end
  end
end
