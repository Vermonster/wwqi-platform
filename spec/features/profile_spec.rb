require 'spec_helper'

describe "user profile" do
  let!(:user) do
    create(:user)
  end

  let!(:question) do
    create(:question, creator: user)
  end

  let!(:discussion) do
    create(:discussion, creator: user)
  end

  let!(:research) do
    create(:research, creator: user)
  end

  let!(:biography) do
    create(:biography, creator: user)
  end

  before(:each) { sign_in(user) }
  after(:each) { sign_out }

  describe "latest" do
    it "shows most recent posts and contributions" do
      visit my_profile_path
      page.should have_content(question.title)
      page.should have_content(discussion.title)
      page.should have_content(research.title)
      page.should have_content(biography.item.name)
    end
  end

  describe "threads" do
    it "shows only questions and discussions" do
      visit my_profile_path(type: "threads")
      page.should have_content(question.title)
      page.should have_content(discussion.title)
      page.should_not have_content(research.title)
      page.should_not have_content(biography.item.name)
    end
  end

  describe "researches" do
    it "shows only research" do
      visit my_profile_path(type: "researches")
      page.should_not have_content(question.title)
      page.should_not have_content(discussion.title)
      page.should have_content(research.title)
      page.should_not have_content(biography.item.name)
    end
  end

  describe "contributions" do
    it "shows only contributions" do
      visit my_profile_path(type: "contributions")
      page.should_not have_content(question.title)
      page.should_not have_content(discussion.title)
      page.should_not have_content(research.title)
      page.should have_content(biography.item.name)
    end
  end

  describe 'collaborations', js: true do
    let!(:collaborate1) { create(:collaborator, user: user) }
    let!(:collaborate2) { create(:collaborator, user: user, post: discussion) }
    let!(:collaborate3) { create(:collaborator, user: user, post: research) }

    it 'has a button for collaborations' do
      visit my_profile_path
      expect(page).to have_link('My Collaborations')
    end

    it 'shows all collaborations a user participates' do
      visit my_profile_path(type: 'collaborations')

      expect(page).to have_content(collaborate1.post.title)
      expect(page).to have_content(collaborate2.post.title)
      expect(page).to have_content(collaborate3.post.title)
    end

    it 'does not show the edit button' do
      visit my_profile_path(type: 'collaborations')

      page.find_link("#{collaborate1.post.title}").hover
      expect(page).not_to have_link('Edit')
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
