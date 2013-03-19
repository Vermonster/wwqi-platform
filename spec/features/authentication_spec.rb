require 'spec_helper'

describe "authentication" do
  before do
    Warden.test_mode!
  end

  describe "signing up" do
    it "lets me sign up" do
      visit '/'
      within('#login-main') do
        fill_in 'user_first_name', with: 'Veronica'
        fill_in 'user_last_name', with: 'Mars'
        fill_in 'sign_up_user_email', with: 'veronica_mars@gmail.com'
        fill_in 'sign_up_user_password', with: 'apples'
        fill_in 'user_password_confirmation', with: 'apples'
        click_on 'Sign Up'
      end

      User.count.should == 1
      User.where(first_name: 'Veronica').first.should_not be_nil
      page.should have_content('You have signed up successfully.')
      current_path.should == posts_path
    end
  end
end
