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

      expect(page).to have_content('Invalid email or password')
    end

    it 'rejects a user when email missing' do
      within('#sign-in') do
        fill_in 'user_password', with: user.password
        click_on 'Sign In'
      end

      expect(page).to have_content('You need to sign in or sign up before continuing.')
    end
  end

  context 'when signing up' do
    it 'lets a user signs up' do
      fill_sign_up('Veronica', 'Mars', 'veronica_mars@gmail.com', 'apples', 'apples', true)
      click_on 'Sign Up'
      sleep 3

      expect(User.count).to eq 1
      expect(User.find_by_first_name('Veronica')).not_to be_nil
      expect(page).to have_content('You have signed up successfully.')
      expect(current_path).to eq my_profile_path
    end

    it 'requires accepting the terms' do
      fill_sign_up('Veronica', 'Mars', 'veronica_mars@gmail.com', 'apples', 'apples', false)
      click_on 'Sign Up'
      sleep 3

      expect(User.count).to eq 0
      expect(page).to have_content('Must be accepted')
    end
  end
  
  context 'when an invitee visits the sign up page' do
    let!(:invitation) { create :invitation }
    let(:invitation_email) { InvitationMailer.new_invitation(invitation).deliver }

    # Visit the link in an invitation email
    before { visit "#{new_user_registration_path}/#{invitation.token}" }

    it 'has the invitation token' do

      # Test the invitation token has copied correctly
      expect(find('#user_token').value).to eq invitation.token
    end

    it 'lets an invitee signs up' do
      fill_sign_up('Veronica', 'Mars', 'veronica_mars@gmail.com', 'apples', 'apples', true)
      click_on 'Sign Up'
      click_on 'My Collaborations'

      test_post = Post.find(invitation.post.id)

      # Test the invitee has added to the correct thread as a collaborator
      expect(Collaborator.count).to eq 1
      expect(test_post.collaborators.length).to eq 1
      expect(test_post.collaborators.first.user.email).to eq 'veronica_mars@gmail.com'

      # Test an invitee can see the thread on his or her profile page
      expect(page).to have_content(test_post.title)
    end
  end

  context 'an administrator signing in' do
    let!(:user) { create(:user, is_admin: true) }
    before do
      sign_in(user)
      visit admin_root_path
    end

    it 'shows the administrator page' do
      expect(page).to have_content('Dashboard')
    end

    it 'redirects to an administrator user profile page when an administrator logout' do
      click_on 'Logout'

      expect(current_path).to eq my_profile_path
    end

    it 'redirects to root when a non administartor tries to visit' do
      sign_out
      visit admin_root_path

      expect(current_path).to eq root_path
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
