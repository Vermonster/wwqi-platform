require 'spec_helper'

feature 'Invitation', js: true do
  context 'as a registered user' do
    let(:user) { create(:user) }

    before do
      sign_in(user)
      visit new_post_path
      click_on 'People I Choose'
      click_on 'Invite a new person to the research platform'
    end

    it 'opens an invitation form' do
      expect(page).to have_selector('.modal-backdrop')
    end

    it 'lets a user adds an invitee' do
      fill_invitation('abc@abc.com', 'AB C', 'I am inviting you.')
      click_button 'Invite'
      sleep 3

      within('#invitation', visible: false) do

        #Check the nested fields are created
        expect(page).to have_selector('.input.hidden.post_invitations_recipient_name', visible: false)
        expect(page).to have_selector('.input.email.required.post_invitations_recipient_email')
        expect(page).to have_selector('.input.hidden.post_invitations_message', visible: false)

        # Check the information has been transferred correctly from the modal
        # form
        expect(find('.input.hidden.post_invitations_recipient_name input', visible: false).value).to eq 'AB C'
        expect(find('.input.email.post_invitations_recipient_email input').value).to eq 'abc@abc.com'
        expect(find('.input.hidden.post_invitations_message input', visible: false).value).to eq 'I am inviting you.'
      end
   end

    it 'lets a user submits a post with an invitee' do
      fill_invitation('abc@abc.com', 'AB C', 'I am inviting you')
      click_button 'Invite'
      # page.execute_script("$('#create_invitation').click()")
      sleep 5
      fill_post('Queen', 'Another one bites the dust.')
      click_on 'Submit'

      expect(page).to have_content('Thread was successfully posted.')
      expect(Invitation.count).to eq 1
    end
    
    it 'allows a user closes an invitation form' do
      click_button 'Cancel'
      sleep 3

      expect(page).not_to have_selector('.modal-backdrop')
    end

    it 'allows a user skips a recipient name and message' do
      fill_invitation('test@test.com', '', '')
      click_button 'Invite'
      fill_post('Test Title', 'This is a test.')
      click_on 'Submit'
      sleep 3

      expect(page).to have_content('Thread was successfully posted.')
    end

    it 'validates a recipient email' do
      fill_invitation('test@test', 'Wrong Email', 'Email validation test')
      click_button 'Invite'
      sleep 3

      expect(page).to have_content('Please check the email address')
    end
  end

  def fill_post(title, detail)
    find('#post_title').visible?
    fill_in 'post_title', with: title
    page.execute_script("editor.setValue('#{detail}')")
  end

  def fill_invitation(email, name, message)
    within('#add_invitation') do
      fill_in 'modal_recipient_name', with: name
      fill_in 'modal_recipient_email', with: email
      fill_in 'modal_message', with: message
    end
  end
end
