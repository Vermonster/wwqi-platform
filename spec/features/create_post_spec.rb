require 'spec_helper'

describe "post creation" do
  describe "without authentication" do
    it "only allows a signed in user to create a new post" do
      visit new_post_path
      current_path.should == root_path 
      page.should have_content("You need to sign in or sign up before continuing.")
    end
  end

  context "authenticated" do
    let(:user) { create(:user, email: 'user@example.com') }

    before { sign_in(user) }
    after { sign_out }

    describe "Start a new thread button" do
      it "goes to the new post form" do
        visit posts_path
        click_on "Start A New Thread"
        current_path.should == new_post_path
      end
    end

    describe "question creation" do
      it "creates a new question" do
        visit new_post_path

        fill_in_required_thread_fields
        click_on 'Submit'

        Question.count.should == 1
        question = Question.last
        current_path.should == post_path(question)
        page.should have_content('Thread was successfully posted.') 
        page.should have_content('a tag')
        page.should have_content('a title')
        page.should have_content('additional details')
      end
    end

    describe "discussion creation" do
      it "creates a new discussion", js: true do
        visit '/'
        click_on 'Questions & Discussions'
        click_on 'Start A New Thread' 

        fill_in 'post_title', with: 'a title'
        page.execute_script("editor.setValue('additional details')")
        click_button 'Discussion'
        click_on 'Create Discussion'

        Discussion.count.should == 1
        discussion = Discussion.last
        current_path.should == post_path(discussion)
        page.should have_content('Thread was successfully posted.') 
        page.should have_content('a title')
        page.should have_content('additional details')
      end
    end
  end

  context "with javascript" do
    describe "question creation with uploads" do
      let(:user) { create(:user) }
      before { sign_in(user) }

      it "creates new uploads", js: true do
        visit new_post_path
        fill_in 'post_title', with: 'a title'
        page.execute_script("editor.setValue('additional details')")
        click_on 'Add Upload'
        page.execute_script("$('.file.optional.upload').toggle();")
        find(".input.file.optional.post_uploads_content").find('input').set("#{Rails.root}/spec/support/Montmarte.jpg")
        click_on 'Submit'

        Question.count.should == 1
        question = Question.last
        current_path.should == post_path(question)
        
        page.should have_content('a title')
        page.should have_content('additional details')
        page.should have_content('Montmarte.jpg')
      end
    end
  end
end
