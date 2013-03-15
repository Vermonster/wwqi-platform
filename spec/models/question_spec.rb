require 'spec_helper'

describe Question do
  it "has a valid factory" do
    build(:question).should be_valid
  end
end
