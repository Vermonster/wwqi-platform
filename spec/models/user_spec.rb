require 'spec_helper'

describe User do
  subject { create(:user) }
  
  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }
  it { should validate_presence_of(:email) }
  it { should respond_to(:password) }
  it { should validate_uniqueness_of(:email) }
  it { should have_many(:posts) }
  it { should have_many(:comments) }
  it { should have_many(:followings) }
  it { should have_many(:followed_posts).through(:followings) }
  it { should have_many(:contributions) }
  
  it "has a valid factory" do
    build(:user).should be_valid
  end


  describe "followings" do
    let!(:user) { create(:user) }

    it "can follow posts" do
      research = create(:research)
      create(:following, followable: research, user: user)

      user.followed_posts.should =~ [research]
    end
    
    it "can retrieve followed questions and discussions" do
      question = create(:question)
      create(:following, followable: question, user: user)

      discussion = create(:discussion)
      create(:following, followable: discussion, user: user)
      
      user.followed_questions_and_discussions.should =~ [question, discussion]
    end
    
    it "can retrieve followed researches" do
      research = create(:research)
      create(:following, followable: research, user: user)

      user.followed_researches.should =~ [research]
    end
  end
end
