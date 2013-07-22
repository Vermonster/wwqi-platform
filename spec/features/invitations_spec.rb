require 'spec_helper'

feature "Post creator(registered user)" do
  describe "as a test user" do
    let(:user) { create(:user) }

    before do
      sign_in(user)
      visit new_post_path
    end

    it 'adds an invitee in the new post page', js: true do
      expect(page).to have_content('SIGN OUT')
      expect(page).to have_content('Additional Details')
      find(:xpath, '//input[@id="post_title"]').visible?

      fill_post('Queen', 'another one bites the dust')
      click_button 'People I Choose'
      page.execute_script('$("#add_invitation").modal("show")')

      # Check the modal form has been opened
      expect(page).to have_selector('.modal-backdrop')
      test_email = 'abc@abc.com'
      test_name = 'AB C'
      test_message = 'This is a test invitation.'

      # Fill the invitation form
      fill_invitation(test_email, test_name, test_message)
      page.execute_script("$('#create_invitation').click()")
      sleep 5 

      # Check the all information has been transferred to the hidden nested
      # fields
      within('#invitation', visible: false) do
        #Check the nested fields are created
        expect(page).to have_selector('.input.hidden.post_invitations_recipient_name', visible: false)
        expect(page).to have_selector('.input.email.required.post_invitations_recipient_email')
        expect(page).to have_selector('.input.hidden.post_invitations_message', visible: false)
        # Check the information has been transferred correctly from the modal
        # form
        find('.input.hidden.post_invitations_recipient_name input', visible: false).value.should == test_name
        find('.input.email.post_invitations_recipient_email input').value.should == test_email
        find('.input.hidden.post_invitations_message input', visible: false).value.should == test_message
      end

      click_button 'Submit'

      expect(page).to have_content('Thread was successfully posted.')
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
      find('#post_title').visible?
      fill_post('Test Title', 'This is a test.')
      page.execute_script('$("#add_invitation").modal("show")')
      sleep 5

      fill_invitation('test@test.com', '', '')
      click_button 'Invite'
      sleep 5

      click_button 'Submit'
      expect(page).to have_content('Thread was successfully posted.')
    end

    it 'adds with a wrong email address', js: true do
      page.execute_script('$("#add_invitation").modal("show")')
      sleep 5

      fill_invitation('test@test', 'Wrong Email', 'This is a test for the emial validation.')
      page.execute_script("$('#create_invitation').click()")
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
    page.execute_script("editor.setValue('#{detail}')")
  end
end
