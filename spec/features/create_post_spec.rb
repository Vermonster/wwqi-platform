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
    before do
      user = create(:user)
      login(user)
    end

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

        fill_in_required_post_fields
        #click_on 'add upload'
        #attach_file 'Choose File', 'spec/support/files/cow.jpg'
        click_on 'Post Thread'

        Post.count.should == 1
        post = Post.last
        current_path.should == post_path(post)
        
        page.should have_content('a tag')
        page.should have_content('a title')
        page.should have_content('additional details')
        #page.should have_content('cow.jpg')
      end
    end

    describe "discussion creation" do
      it "creates a new discussion" do

      end

    end

    describe "question creation with uploads" do
      it "creates new uploads" do

      end
    end
  end
end
