require 'spec_helper'
include Warden::Test::Helpers

feature "Post creator(registered user)" do
  describe "as a test user" do
    before :each do
      @user = create(:user)
      visit new_post_path
      click_on 'Login'
      expect(page).to have_content('SIGN IN')
      fill_in 'Email', with: @user.email 
      fill_in 'Password', with: @user.password
      click_button 'Sign in'
      visit new_post_path
    end

    after :each do
      click_on 'Logout'
    end

    it 'adds an invitee in the new post page', js: true do
      expect(page).to have_content('LOGOUT')
      expect(page).to have_content('Additional Details')
      find(:xpath, '//input[@id="post_title"]').visible?
      find(:xpath, '//textarea[@class="text required span12 wysihtml5"').visible?
      # within(".input.text.required.post_details") do
      #   find(:xpath, '//textarea[@id="post_details"]').visible?
      # end

      # fill_post('Test Title', 'This is a test post.')
      # Skipping Autocomplete test due to the incompatibility with Poltergeist

      # Open the invitaion form manually
      # page.execute_script('$("#add_invitation").modal("show")')
      # sleep 5

      # Check the modal form has been opened
      expect(page).to have_selector('.modal-backdrop')
      test_email = 'abc@abc.com'
      test_name = 'AB C'
      test_message = 'This is a test invitation.'

      # Fill the invitation form
      fill_invitation(test_email, test_name, test_message)

      click_button 'Invite'
      sleep 5

      # Check the all information has been transferred to the hidden nested
      # fields
      within('#invitation') do

        #Check the nested fields are created
        expect(page).to have_selector('.string.email.required')
        expect(page).to have_selector('.input.hidden.post_invitations_recipient_name')
        expect(page).to have_selector('.input.hidden.post_invitations_message')
        # Check the information has been transferred correctly from the modal
        # form
        find('.input.hidden.post_invitations_recipient_name').find('input').value.should == test_name
        find('.string.email.required').value.should == test_email
        find('.input.hidden.post_invitations_message').find('input').value.should == test_message
      end

      click_button 'Submit Question'
      expect(page).to have_content('Thread was successfully created.')
    end

    it 'closes the invitation form by clicking either Cancel button or X button', js: true do
      # Open the invitation form
      page.execute_script('$("#add_invitation").modal("show")')
      sleep 5

      # Make sure the invitaion form is opened
      expect(page).to have_selector('.modal-backdrop')
      expect(page).to have_button('Cancel')

      # Close the form
      click_button 'Cancel'
      sleep 5

      # Check the form is closed
      expect(page).to_not have_selector('.modal-backdrop')
    end

    it 'adds a invitee without a recipient name and message', js: true do
      fill_post('Test Title', 'This is a test.')
      page.execute_script('$("#add_invitation").modal("show")')
      sleep 5

      fill_invitation('test@test.com', '', '')
      click_button 'Invite'
      sleep 5

      click_button 'Submit Question'
      expect(page).to have_content('Thread was successfully created.')
    end

    it 'adds with a wrong email address', js: true do
      page.execute_script('$("#add_invitation").modal("show")')
      sleep 5

      fill_invitation('test@test', 'Wrong Email', 'This is a test for the emial validation.')
      click_button 'Invite'
      sleep 5

      # Check the error message is showed up
      expect(page).to have_content('Please check the email address')
      click_button 'Cancel'
    end
  end

  def fill_invitation(email, name, message)
    within('#add_invitation') do
      fill_in 'modal_recipient_name', with: name
      fill_in 'modal_recipient_email', with: email
      fill_in 'modal_message', with: message
    end
  end

  def fill_post(title, detail)
    fill_in 'post_title', with: title
    # Need to use xpath to locate the hidden text area
    # fill_in 'post_details', with: detail
    find('post_title').visible?
    # within(".input.text.required.post_details") do
    #   find_xpath('#id="post_details"').set(detail)
    #   find(:xpath, './[@id="post_details"]').value.should == detail
    # end
  end
end
