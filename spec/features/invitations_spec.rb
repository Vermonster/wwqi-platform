require 'spec_helper'

feature "User invites" do

  context 'as a logged in user' do
    let(:test_user) { create :user }

    before :each do
      sign_in(test_user)
    end

    after :each do
      sign_out
    end

    scenario 'using Invite someone else! button', js: true do
      visit new_post_path
      within('#collaborators') do
        # Locate the plus icon and click it
        find(:xpath, "div[@class='links']/a[@class='icon-plus-sign add_fields']").click
        # Check there is a minus icon
        expect(page).to have_xpath("div[@class='nested-fields row-fluid']/div[@class='links span2']/a[@class='icon-minus-sign remove_fields dynamic']")
        expect(page).to have_xpath("div[@class='nested-fields row-fluid']/div[@class='span10']/div[@class='input string optional post_collaborators_term']")
        
        # Bring the autocomplete list
        find(:xpath, "div[@class='nested-fields row-fluid']/div[@class='span10']/div[@class='input string optional post_collaborators_term']/input[@*]").set('e')
        # find('.ui-menu-item a:contains("Invite")').click
        # expect(page).to have_selector('.ui-menu-item')
      end
      # expect(page).to have_content('Recipient email')
      selector = "input[class^=\"string optional ui-autocomplete-input\"]"
      page.execute_script("$(\'#{selector}\').val(\'c\');")
      #sleep 3
      expect(page).to have_content('Invite someone else!')
    end

    scenario 'in the invitation page' do
      visit '/invitations/new'
      expect(page).to have_content('Recipient email')
      expect(page).to have_content('Recipient name')
      expect(page).to have_content('Message')
      expect(page).to have_content("From: #{ test_user.fullname }")
    end

    scenario 'with invalid email' do
      send_invitation('invalid_email', 'John Doe', 'I invite you.')
      expect(page).to have_content('Wrong email format')
    end

    scenario 'with blank email' do 
      send_invitation('', 'Blank Email', 'It should not be sent.')
      expect(page).to have_content('Recipient email can\'t be blank')
    end

    scenario 'with all valid information' do 
      send_invitation('test@example.com', 'Test User', 'This is a test invitation message.')
      expect(page).to have_content('The invitation has been sent.')
    end

    scenario 'with without message' do
      send_invitation('test@example.com', 'Default Message', '')
      expect(page).to have_content('The invitation has been sent.')
    end
  end

  def send_invitation(email, name, message)
    visit new_invitation_path
    fill_in 'Recipient email', with: email
    fill_in 'Recipient name', with: name
    fill_in 'Message', with: message
    click_button 'Send the invitation'
  end
end
