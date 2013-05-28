require 'spec_helper'

describe ItemRelation do
  it { should belong_to :item }
  it { should belong_to :itemable }

  it "has a valid factory" do
    build(:item_relation).should be_valid
  end
end
