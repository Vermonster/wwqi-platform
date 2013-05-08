require 'spec_helper'

feature "follow button", js: true do
  describe "as a public user" do
    let!(:user) { create(:user) }
    let!(:question) { create(:question) }

    it "doesn't show the follow button" do
      visit posts_path
      page.find('ul.items li').hover
      page.should_not have_content('Follow')
    end
  end

  describe "as a logged in user" do
    let!(:user) { create(:user) }
    let!(:question) { create(:question) }

    before(:each) do
      sign_in_with(user.email, 'password')
    end

    it 'allows me to follow a post' do
      visit posts_path
      page.find('ul.items li').hover
      find_link('Follow').should be_visible
      click_on 'Follow'
      expect { user.reload.followings.present? }.to become_true
      #find_link('Follow').should_not be_visible
      find_link('Unfollow').should be_visible

      user.followings.count.should == 1
    end

    it 'allows me to unfollow a post' do
      create(:following, user: user, followable: question)
      
      visit posts_path
      page.find('ul.items li').hover
      find_link('Unfollow').should be_visible
      click_on 'Unfollow'
      expect { user.reload.followings.empty? }.to become_true
      #find_link('Unfollow').should_not be_visible
      find_link('Follow').should be_visible

      user.followings.count.should == 0
    end
  end
end
