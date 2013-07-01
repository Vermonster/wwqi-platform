require 'spec_helper'

describe 'process request from qajarwomen' do
  let(:user) { create :user }
  let(:new_question_request) { '/threads/new?type=question&accession_no=1145A13' }
  let(:new_discussion_request) { '/threads/new?type=discussion&accession_no=1145A13' }
  let(:new_research_request) { '/researches/new?accession_no=1145A13' }

  context 'a new question request' do
    it 'asks sign up or sign in first' do
      visit new_question_request
      expect(page).to have_content('You need to sign in or sign up before continuing.')
    end

    it 'shows the pre-filled question form after sign in', js: true do
      visit new_question_request
      fill_signin
      click_on 'Sign In'
      sleep 5
      
      current_path.should == new_post_path
      find('input[id="post_type"]', visible: false).value.should == 'Question'
      check_item_info
    end

    it 'shows the pre-filled question form after sign up', js: true do
      visit new_question_request
      fill_signup
      click_on 'Sign Up'
      sleep 5

      current_path.should == new_post_path
      find('input[id="post_type"]', visible: false).value.should == 'Question'
      check_item_info
    end
  end

  context 'a new discussion request' do
    it 'asks sign up or sign in first' do
      visit new_discussion_request
      expect(page).to have_content('You need to sign in or sign up before continuing.')
    end

    it 'shows the pre-filled discussion form after sign in', js: true do
      visit new_discussion_request
      fill_signin
      click_on 'Sign In'
      sleep 5
      
      current_path.should == new_post_path
      find('input[id="post_type"]', visible: false).value.should == 'Discussion'
      check_item_info
    end

    it 'shows the pre-filled discussion form after sign up', js: true do
      visit new_discussion_request
      fill_signup
      click_on 'Sign Up'
      sleep 5

      current_path.should == new_post_path
      find('input[id="post_type"]', visible: false).value.should == 'Discussion'
      check_item_info
    end
  end

  context 'a new research request' do
    it 'asks sign up or sign in first' do
      visit new_research_request
      expect(page).to have_content('You need to sign in or sign up before continuing.')
    end

    it 'shows the pre-filled research form after sign in', js: true do
      visit new_research_request
      fill_signin
      click_on 'Sign In'
      sleep 5
      
      current_path.should == new_research_path
      check_item_info
    end

    it 'shows the pre-filled research form after sign up', js: true do
      visit new_research_request
      fill_signup
      click_on 'Sign Up'
      sleep 5

      current_path.should == new_research_path
      check_item_info
    end
  end

  # Helpers
  def fill_signin
    within('#sign-in') do
      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password
    end
  end

  def fill_signup
    within('#registration') do
      fill_in 'user_first_name', with: 'Alan'
      fill_in 'user_last_name', with: 'Parsons'
      fill_in 'sign_up_user_email', with: 'alan_parsons@emc.com'
      fill_in 'sign_up_user_password', with: 'password'
      fill_in 'user_password_confirmation', with: 'password'

      # Because js is true for this test, check 'user_terms' does not work.
      # Check commands can not locate the hidden checkbox. The
      # field shoul be located by find and set the value by replace. 
      find('input[name="user[terms]"][type="hidden"]', visible: false).set "1"
    end
  end

  def check_item_info
    find('input[id$="_item_relations_attributes_0_url"]', visible: false).value.should == '/en/items/1145A13.html'
    find('input[id$="_item_relations_attributes_0_thumbnail"]', visible: false).value.should == 'http://s3.amazonaws.com/assets.qajarwomen.org/thumbs/it_3438.jpg?1345647766'
    find('input[id$="_item_relations_attributes_0_accession_no"]', visible: false).value.should == '1145A13'
    find('input[id$="_item_relations_attributes_0_name"]', visible: false).value.should == 'Patchwork'
  end
end
