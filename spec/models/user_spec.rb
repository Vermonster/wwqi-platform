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
  
  it "has a valid factory" do
    build(:user).should be_valid
  end
end
