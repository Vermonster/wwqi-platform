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
  
end
