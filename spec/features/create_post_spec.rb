require 'spec_helper'

describe "post creation" do
  context "without authentication" do
    it "only allows a signed in user to create a new post" do
      visit posts_path
      click_link 'Start A New Thread'

      expect(page).to have_content('You need to sign in or sign up before continuing')
    end
  end

  context "authenticated" do

    let(:user1) { create(:user) }

    describe "Start a new thread button" do
      it "goes to the new post form" do
        sign_in user1

        visit posts_path
        click_link 'Start A New Thread'

        expect(current_path).to eq(new_post_path)
      end
    end

    describe "question creation" do
      it "creates a new question" do
        sign_in user1

        visit posts_path
        click_link 'Start A New Thread'

        fill_in('Your Concise Question', with: 'What is this group for?')
        click_on('Submit')

        #check path
        expect(current_path).to eq(post_path(0))
        #check database
        #check confirmation msg
        #check user 'asked a question'
        #check title created
        #checkout msg created

      end
    end

    describe "discussion creation" do
      it "creates a new discussion", js: true do
      end
    end
  end

  context "with javascript" do
    describe "question creation with uploads" do

      it "creates new uploads", js: true do
      end
    end
  end
end
