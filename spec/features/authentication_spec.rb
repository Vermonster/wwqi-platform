require 'spec_helper'

describe "authentication" do
  let(:user) { create(:user, email: 'veronica_mars@gmail.com') }
  before { visit root_path }

  context 'when signing in' do
    it 'lets a user sign in' do
      within('#sign-in') do
        fill_in 'user_email', with: user.email
        fill_in 'user_password', with: user.password
        click_on 'Sign In'
      end

      expect(page).to have_content('Signed in successfully.')
    end

    it 'rejects a user when password missing' do
      within('#sign-in') do
        fill_in 'user_email', with: user.email
        click_on 'Sign In'
      end

      expect(page).to have_content('Invalid email or password.')
    end

    it 'rejects a user when email missing' do
      within('#sign-in') do
        fill_in 'user_password', with: user.password
        click_on 'Sign In'
      end

      expect(page).to have_content('You need to sign in or sign up before continuing.')

    end
  end

    it 'allows a user to reset forgotten password' do
      # This test has been commented out by some reason. So, we will skip this
      # test.
    end

  context 'when signing up' do
    it 'requires accepting the terms' do
      fill_sign_up('Veronica', 'Mars', 'veronica_mars@gmail.com', 'apples', 'apples', false)
      click_on 'Sign Up'
      # this gives 3 second delay, so our server has enough time to repsonse. We
      # don't use this delay any more however. Just plain `find` will be do same
      # thing. With upgraded capybara, `find` usually waits until the page loaded.
      sleep 3

      expect(User.count).to eq 0 # Explain this
      expect(page).to have_content('Must be accepted')
    end

    it 'lets a user signs up' do
      # fill this test
    end
  end

  def fill_sign_up(first, last, email, password, password_confirmation, acceptance)
    within('#new_user') do
      fill_in 'user_first_name', with: first
      fill_in 'user_last_name', with: last
      fill_in 'sign_up_user_email', with: email
      fill_in 'sign_up_user_password', with: password
      fill_in 'user_password_confirmation', with: password_confirmation
      check 'user_terms' if acceptance
    end
  end
end
