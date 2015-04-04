require 'spec_helper'

describe "user profile" do

  let(:user1) { create(:user) }

  before do
    sign_in user1
  end

  describe "latest" do
    it "shows most recent posts and contributions" do
      question = create(:question, creator: user1, created_at: DateTime.now - 10)
      discussion = create(:discussion, creator: user1, created_at: DateTime.now - 2)

      visit my_profile_path

      expect(page).to have_content(question.title)
      expect(page).to have_content(discussion.title)

      expect(page).to have_content("#{user1.fullname} asked a question")
      expect(page).to have_content("#{user1.fullname} started a discussion")
      expect(page).to have_content('no replies')
      expect(page).to have_content('no answers')

      first_post = first('.item-created')
      expect(first_post).to have_content('2 days ago')
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
