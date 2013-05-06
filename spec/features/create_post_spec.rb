require 'spec_helper'

describe "post creation" do
  describe "without authentication" do
    it "only allows a signed in user to create a new post" do
      visit new_post_path
      current_path.should == new_user_session_path
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
        click_on 'Submit Question'

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
        pending('resolution of login issues')

        sign_in_with(user.email, user.password) 
        click_on 'Questions & Discussions'
        click_on 'Start A New Thread' 

        fill_in_required_thread_fields
        click_button 'Discussion'
        click_on 'Create Discussion'

        Discussion.count.should == 1
        discussion = Discussion.last
        current_path.should == post_path(discussion)
        page.should have_content('Thread was successfully posted.') 
        page.should have_content('a tag')
        page.should have_content('a title')
        page.should have_content('additional details')
      end
    end
  end

  context "with javascript" do
    describe "question creation with uploads" do
      let(:user) { create(:user) }

      it "creates new uploads", js: true do
        pending('work in progress')
        sign_in_with(user.email, 'password')

        visit new_post_path

        fill_in_required_thread_fields
        click_on 'add upload'
        file_field = page.find('.upload')
        file_field.set 'spec/support/files/cow.jpg'
        click_on 'Post Thread'

        Question.count.should == 1
        question = Question.last
        current_path.should == post_path(question)
        
        page.should have_content('a tag')
        page.should have_content('a title')
        page.should have_content('additional details')
        page.should have_content('cow.jpg')
      end
    end
  end
end
