require 'spec_helper'

feature "follow button", js: true do
  let(:user) { create(:user) }
  let(:question) { create(:question, title: 'Test Question', creator: user) }
  let(:item) { create(:item, thumbnail: 'http://s3.amazonaws.com/assets.qajarwomen.org/thumbs/it_3438.jpg?1345647766')}
  let(:item_relation) { create(:item_relation, itemable: question, item: item) }
  let!(:transcription) { create(:transcription, item_relation: item_relation, creator: user) }

  describe "as a public user" do
    it "doesn't show the follow button on the post page" do
      # on the question or discussion index page
      visit posts_path
      page.find('ul.items li').hover

      page.should_not have_content('Follow')
    end

    it "doesn't show the follow button on the contribution page" do
      # on the contribution index page
      visit contributions_path
      page.find('ul.items#recent-contributions li').hover
      
      expect(page).not_to have_content('Follow')
    end
  end

  describe "as a logged in user" do

    before do
      sign_in_with(user.email, 'password')
    end

    it 'allows me to follow a post' do
      visit posts_path
      page.find('ul.items li').hover

      find_link('Follow').should be_visible

      click_on 'Follow'

      expect { user.reload.followings.present? }.to become_true
      find_link('Unfollow').should be_visible
      user.followings.count.should == 1
    end

    it 'allows me to unfollow a post' do
      create(:following, user: user, followable: question)
      visit posts_path

      find_link('Unfollow').should be_visible
      
      click_on 'Unfollow'
      
      expect { user.reload.followings.empty? }.to become_true
      find_link('Follow').should be_visible
      user.followings.count.should == 0
    end

    it 'allows me to follow a contribution' do
      visit contributions_path
      page.find('ul.items#recent-contributions li').hover

      find_link('Follow').should be_visible
      
      click_on 'Follow'
      
      expect { user.reload.followings.present? }.to become_true
      find_link('Unfollow').should be_visible
      user.followings.count.should == 1
    end

    it 'allows me to unfollow a contribution' do
      create(:following, user: user, followable: transcription)
      visit contributions_path

      find_link('Unfollow').should be_visible
      
      click_on 'Unfollow'
      
      expect { user.reload.followings.empty? }.to become_true
      find_link('Follow').should be_visible
      user.followings.count.should == 0
    end
  end
end
