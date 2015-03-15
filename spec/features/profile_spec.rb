require 'spec_helper'

describe "user profile" do
  describe "latest" do
    it "shows most recent posts and contributions" do
    end
  end

  describe "threads" do
    it "shows only questions and discussions" do
    end
  end

  describe "researches" do
    it "shows only research" do
    end
  end

  describe "contributions" do
    it "shows only contributions" do
    end
  end

  describe 'collaborations', js: true do
    it 'has a button for collaborations' do
    end

    it 'shows all collaborations a user participates' do
    end

    it 'does not show the edit button' do
    end

  end

  # describe "followings" do
  #   let(:following) { create_list(:following, 5, user: user) }

  #   it 'has a button for followings' do
  #     visit my_profile_path
  #     expect(page).to have_link('Following')
  #   end

  #   it 'shows the posts and the contribution an user follows' do

  #     visit my_profile_path(type: 'followings')
  #     expect(page).to have_content()

  #   end
  # end

end
