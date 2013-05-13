require 'spec_helper'

describe Comment do
  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:commentable_id) }
  it { should validate_presence_of(:details) }
  it { should belong_to(:user) }
  it { should belong_to(:commentable) }
  it { should have_many(:uploads) }
  it { should have_many(:notifications) }
  it { should have_many(:items) }

  it "has a valid factory" do
    build(:comment).should be_valid
  end
end
