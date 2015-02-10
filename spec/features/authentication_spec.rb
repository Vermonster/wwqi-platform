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

    it 'allows a user to reset forgotten password' do

    end
  end
end
