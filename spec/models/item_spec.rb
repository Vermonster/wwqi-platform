require 'spec_helper'

describe Item do
  it { should validate_presence_of(:url) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:thumbnail) }
  it { should validate_presence_of(:accession_no) }
  it { should belong_to(:post) }
  it { should belong_to(:comment) }

  it "has a valid factory" do 
    build(:item).should be_valid
  end
end
