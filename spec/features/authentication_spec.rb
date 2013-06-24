require 'spec_helper'

describe "authentication" do
  before do
    Warden.test_mode!
  end

  describe "signing in" do
    before do
      create :user, email: 'veronica_mars@gmail.com'
    end

    it "lets me sign in" do
      visit '/'
      within('#sign-in-main') do
        fill_in 'user_email', with: 'veronica_mars@gmail.com'
        fill_in 'user_password', with: 'password'
        click_on 'Sign In'
      end
      page.should have_content('Signed in successfully.')
    end

    it "lets me sign in" do
      visit '/'
      within('#sign-in-main') do
        fill_in 'user_email', with: 'veronica_mars@gmail.com'
        click_on 'Sign In'
      end
      page.should have_content('Invalid email or password.')
      within('#sign-in-main') do
        fill_in 'user_password', with: 'password'
        click_on 'Sign In'
      end
    end
  end

  describe "signing up" do
    it "lets me sign up" do
      visit '/'
      within('#sign-in-main') do
        fill_in 'user_first_name', with: 'Veronica'
        fill_in 'user_last_name', with: 'Mars'
        fill_in 'sign_up_user_email', with: 'veronica_mars@gmail.com'
        fill_in 'sign_up_user_password', with: 'apples'
        fill_in 'user_password_confirmation', with: 'apples'
        check 'user_terms'
        click_on 'Sign Up'
      end

      User.count.should == 1
      User.where(first_name: 'Veronica').first.should_not be_nil
      page.should have_content('You have signed up successfully.')
      current_path.should == my_profile_path
    end

    it 'requires accepting the terms' do
      visit '/'
      within('#sign-in-main') do
        fill_in 'user_first_name', with: 'Veronica'
        fill_in 'user_last_name', with: 'Mars'
        fill_in 'sign_up_user_email', with: 'veronica_mars@gmail.com'
        fill_in 'sign_up_user_password', with: 'apples'
        fill_in 'user_password_confirmation', with: 'apples'
        click_on 'Sign Up'
      end

      User.count.should == 0
      within('.terms') do
        page.should have_content('must be accepted')
      end
      within('#sign-in-main') do
        fill_in 'sign_up_user_password', with: 'apples'
        fill_in 'user_password_confirmation', with: 'apples'
        check 'user_terms'
        click_on 'Sign Up'
      end
      User.count.should == 1
      User.where(first_name: 'Veronica').first.should_not be_nil
      page.should have_content('You have signed up successfully.')
      current_path.should == my_profile_path
    end
  end

  describe 'singing up as an invitee' do
    let!(:invitation) { create :invitation }
    it 'signs up with the invitation token' do
      # Visit to the sign up path with an invitation token
      visit "/users/sign_up/#{invitation.token}"

      within('#sign-in-main') do
        # Test token value has been successfully filled in
        find('#user_token').value == invitation.token

        # Fill the sign up form
        fill_in 'user_first_name', with: 'Veronica'
        fill_in 'user_last_name', with: 'Mars'
        fill_in 'sign_up_user_email', with: 'veronica_mars@gmail.com'
        fill_in 'sign_up_user_password', with: 'apples'
        fill_in 'user_password_confirmation', with: 'apples'
        check 'user_terms'
        click_on 'Sign Up'
      end

      # Load the post created by the invitation factory
      test_post = Post.find(invitation.post.id)

      # Test a collaborator has been added to the post
      test_post.collaborators.length.should == 1

      # Test the added collaborator is the invitee
      test_post.collaborators.first.user.email.should == 'veronica_mars@gmail.com'

      # Test there is no collaborator added except the invitee
      Collaborator.count.should == 1

      # Test the current path is the invitee profile path
      current_path.should == my_profile_path
    end
    
  end
  
  describe "signing in as an admin" do
    let!(:user) do
      create(:user, email: 'veronica_mars@gmail.com', is_admin: true)
    end
    
    before do
      sign_in(user)
      visit '/admin'
    end
  
    it "lets me visit the admin pages" do
      page.should have_content('Dashboard')
    end
    
    it "redirects to profile page on logout" do
      click_on 'Logout'
      current_path.should == '/me'
    end
  end
  
  describe "visiting pages without signing in" do
    it "redirects if there is no current user" do
      visit '/admin'
      current_path.should == '/'
    end
  end
end
