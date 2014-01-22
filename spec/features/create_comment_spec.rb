require 'spec_helper'
require 'ffaker'

describe 'comment creation' do
  let!(:question) { create(:question) }
  let!(:transcription) { create(:transcription) }
  let(:user) { create(:user) }

  describe 'without authentication' do
    it 'only allows a signed in user to create a new comment' do
      visit post_path(question)
      page.should have_content("To comment on this question, please sign in.")

      visit contribution_path(transcription)
      expect(page).to have_content("To comment on this transcription, please sign in.")
    end
  end

  describe 'submit a comment for a contribution' do
    it 'creates a new comment and redirects back to the parent page' do
      sign_in(user)
      visit contribution_path(transcription)
      within('.comment-box') do
        fill_in 'comment_details', with: 'squirrel'
        click_on 'Create comment'
      end

      Comment.count.should == 1
      current_path.should == contribution_path(transcription)
      within('.comments') do
        expect(page).to have_content("#{user.fullname} commented")
        expect(page).to have_content('squirrel')
      end
    end
  end

  describe 'submit a comment for a question' do
    before { sign_in(user) }
    
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

      # Check the item thumbnails
      within('.comments') do
        expect(page).to have_content(text_with_links)
        expect(page).to have_selector("img[src='#{first_link_thumbnail}']")
        expect(page).to have_selector("img[src='#{second_link_thumbnail}']")
      end
    end

    it 'creates a new somment with a missing item url and fix it' do
      visit posts_path
      click_on question.title

      # Missing item information
      missing_link = 'http://www.qajarwomen.org/en/items/2333A11.html'
      missing_thumbnail = '/assets/flag.png'

      correct_link = 'http://www.qajarwomen.org/en/items/1333A11.html'
      correct_thumbnail = 'http://s3.amazonaws.com/assets.qajarwomen.org/thumbs/it_1754.jpg?1329177600'

      within('.comment-box') do
        fill_in 'comment_details', with: missing_link
        click_on 'Submit answer'
      end

      # Missing item is stored as an item without causing any error
      current_path.should == post_path(question)

      # Check the not found image displayed as a thumbnail
      within('.comments') do
        expect(page).to have_content(missing_link)
        expect(page).to have_selector("img[src='#{missing_thumbnail}']")
      end

      within('.comments') do
        click_on 'edit'
      end

      # Check the correct comment edit page displayed
      expect(page).to have_button('Update Comment')
      expect(page).to have_content(missing_link)
      
      # Update the comment with a correct item url
      find('textarea').set(correct_link)
      click_on 'Update Comment'

      # Check it updates correctly
      current_path.should == post_path(question)
      expect(page).to have_content("Updated successfully")

      # Check updated item url
      within('.comments') do
        expect(page).to have_content(correct_link)
        expect(page).to have_selector("img[src='#{correct_thumbnail}']")
      end
    end
  end

  describe 'comment notifications' do
    let(:follower1) { create(:user) }
    let(:follower2) { create(:user) }

    it 'creates a notification for each follower' do
      sign_in(user)
      create(:following, followable: question, user: user)
      create(:following, followable: transcription, user: user)
      create(:following, followable: question, user: follower1)
      create(:following, followable: transcription, user: follower1)
      create(:following, followable: question, user: follower2)
      create(:following, followable: transcription, user: follower2)

      visit post_path(question)
      within('.comment-box') do
        fill_in 'comment_details', with: 'squirrel'
        click_on 'Submit answer'
      end

      user.notifications.count.should == 0
      follower1.notifications.count.should == 1
      follower2.notifications.count.should == 1

      visit contribution_path(transcription)
      within('.comment-box') do
        fill_in 'comment_details', with: 'squirrel'
        click_on 'Create comment'
      end

      user.notifications.count.should == 0
      follower1.notifications.count.should == 2
      follower2.notifications.count.should == 2
    end
  end
end
