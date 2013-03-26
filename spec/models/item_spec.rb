require 'spec_helper'

describe Item do
  it { should validate_presence_of(:url) }
  it { should belong_to(:post) }
  it { should validate_presence_of(:post_id) }

  it "has a valid factory" do 
    build(:item).should be_valid
  end
end