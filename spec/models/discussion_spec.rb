require 'spec_helper'

describe Discussion do
  it "has a valid factory" do
    build(:discussion).should be_valid
  end
end

