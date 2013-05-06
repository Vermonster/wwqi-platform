require 'spec_helper'

describe "research creation" do
  describe "without authentication" do
    it "only allows a signed in user to create a new post" do
      visit new_research_path
      current_path.should == new_user_session_path
      page.should have_content("You need to sign in or sign up before continuing.")
    end
  end

  context "authenticated" do
    let(:user) { create(:user) }

    before(:each) do
      sign_in(user)
    end

    after(:each) do
      sign_out
    end

    describe "Submit your research button" do
      it "goes to the new research form" do
        visit researches_path
        click_on "Submit Your Research"
        current_path.should == new_research_path
      end
    end

    describe "research creation" do
      it "creates new research" do
        visit new_research_path

        fill_in_required_research_fields
        click_on 'Submit Research'

        Research.count.should == 1
        research = Research.last
        current_path.should == research_path(research)
        page.should have_content('Research was successfully posted.') 
        page.should have_content('a tag')
        page.should have_content('a title')
        page.should have_content('additional details')
      end
    end
  end
end
