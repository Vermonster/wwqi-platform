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

      first_post = first('.item-created')
      expect(first_post).to have_content('2 days ago')
    end
  end

  describe "threads" do
    it "shows only questions and discussions" do
      question = create(:question, creator: user1)
      discussion = create(:discussion, creator: user1)
      research = create(:research, creator: user1)

      visit my_profile_path

      click_link('My Questions and Discussions')

      expect(page).to have_content(question.title)
      expect(page).to have_content(discussion.title)
      expect(page).to have_content("#{user1.fullname} asked a question")
      expect(page).to have_content("#{user1.fullname} started a discussion")
      expect(page).to have_content('no replies')
      expect(page).to have_content('no answers')
      expect(page).to_not have_content(research.title)
    end
  end

  describe "researches" do
    it "shows only research" do
      question = create(:question, creator: user1)
      discussion = create(:discussion, creator: user1)
      research = create(:research, creator: user1)

      visit my_profile_path

      click_link('My Research-in-Progress')

      expect(page).to have_content(research.title)
      expect(page).to have_content("#{user1.fullname} shared research in progress")
      expect(page).to have_content('no comments')

      expect(page).to_not have_content(question.title)
      expect(page).to_not have_content(discussion.title)
    end
  end

  describe "contributions" do
    it "shows only contributions" do
      question = create(:question, creator: user1)
      discussion = create(:discussion, creator: user1)
      research = create(:research, creator: user1)
      transcription = create(:transcription, creator: user1)
      translation = create(:translation, creator: user1)
      biography = create(:biography, creator: user1)
      correction = create(:correction, creator: user1)

      visit my_profile_path

      click_link('My Contributions')

      expect(page).to have_content("#{user1.fullname} contributed a transcription for")
      expect(page).to have_content("#{user1.fullname} contributed a translation for")
      expect(page).to have_content("#{user1.fullname} contributed a biography for")
      expect(page).to have_content("#{user1.fullname} contributed a correction for")
      expect(page).to have_content(transcription.title)
      expect(page).to have_content(translation.title)
      expect(page).to have_content(biography.title)
      expect(page).to have_content(correction.title)
      expect(page).to have_content('no comments')

      expect(page).to_not have_content(question.title)
      expect(page).to_not have_content(discussion.title)
      expect(page).to_not have_content(research.title)
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
