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

    before do
      sign_in user1
      visit posts_path
      click_link 'Start A New Thread'
    end

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
        fill_in('Additional Details', with: 'test content')
        click_button('Submit')

        expect(current_path).to eq(post_path(1))
        expect(Question.count).to eq 1
        expect(page).to have_content('Thread was successfully posted')
        expect(page).to have_content("#{user1.fullname} asked a question")
        expect(page).to have_content('What is this group for?')
        expect(page).to have_content('test content')
      end
    end

    describe "discussion creation" do
      it "creates a new discussion", js: true do
        sign_in user1

        visit posts_path
        click_link 'Start A New Thread'
        click_button 'Discussion'

        fill_in('Your Discussion Title', with: 'This is discussion title')
        page.execute_script("editor.setValue('this is the content for additional details');")
        click_button 'Create Discussion'

        expect(current_path).to eq(post_path(1))
        expect(Discussion.count).to eq 1
        expect(page).to have_content('Thread was successfully posted')
        expect(page).to have_content("#{user1.fullname} started a discussion")
        expect(page).to have_content('This is discussion title')
        expect(page).to have_content('this is the content for additional details')
      end
    end

    describe "question creation with uploads" do
      it "creates new uploads", js: true do
        sign_in user1

        visit posts_path
        click_link 'Start A New Thread'

        fill_in('Your Concise Question', with: 'What is this group for?')
        page.execute_script("editor.setValue('this is the content for additional details');")

        click_link 'Add Upload'
        page.execute_script("$('.file.optional.upload').toggle();")
        find(".input.file.optional.post_uploads_content").find('input').set("#{Rails.root}/spec/support/Montmarte.jpg")
        click_button 'Submit'

        expect(current_path).to eq(post_path(1))
        expect(Question.count).to eq 1
        expect(page).to have_content()

      end
    end
  end

end
