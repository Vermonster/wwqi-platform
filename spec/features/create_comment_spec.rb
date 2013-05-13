require 'spec_helper'
require 'ffaker'

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

    it 'creates a new comment with item urls' do
      visit '/'
      visit posts_path
      click_on question.title

      # Add the information of two item links
      first_link = "http://www.qajarwomen.org/en/items/1016A200.html"
      first_link_name = "Infant headband"
      first_link_thumbnail = 
        "http://s3.amazonaws.com/assets.qajarwomen.org/thumbs/it_200.jpg?1329177600"
      second_link = "http://www.qajarwomen.org/en/items/1016A215.html"
      second_link_name = 
       "Chador" 
      second_link_thumbnail = 
        "http://s3.amazonaws.com/assets.qajarwomen.org/thumbs/it_271.jpg?1329177600"
      # Create a random text with one ordinary link and two item links
      text_with_links = Faker::Lorem.paragraph
      text_with_links << " " << Faker::Internet.http_url
      text_with_links << " " << Faker::Lorem.paragraph
      text_with_links << " " << first_link << " " << second_link

      within('.comment-box') do
        fill_in 'comment_details', with: text_with_links
        click_on 'Submit answer'
      end

      # Check the location after the submission
      current_path.should == post_path(question)

      # Check the item names and thumbnails
      within('.comments') do
        expect(page).to have_content(text_with_links)
        expect(page).to have_css('p', text: first_link_name)
        expect(page).to have_css('p', text: second_link_name)
        expect(page).to have_selector("img[src='#{first_link_thumbnail}']")
        expect(page).to have_selector("img[src='#{second_link_thumbnail}']")
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
