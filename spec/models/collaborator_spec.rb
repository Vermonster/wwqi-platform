require 'spec_helper'

describe Collaborator do
  it { should belong_to(:post) }
  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:post_id) }

  it "has a valid factory" do
    build(:collaborator).should be_valid
  end
end
