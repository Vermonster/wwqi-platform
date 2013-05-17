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
end
