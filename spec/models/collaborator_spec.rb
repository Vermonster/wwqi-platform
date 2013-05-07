require 'spec_helper'

describe Collaborator do
  it { should belong_to(:post) }

  it "has a valid factory" do
    build(:collaborator).should be_valid
  end
end
