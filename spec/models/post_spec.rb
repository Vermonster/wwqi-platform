require 'spec_helper'

describe Post do
  it { should respond_to(:type) }
  it { should respond_to(:tag_list) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:details) }
  it { should have_many(:uploads) }
  it { should respond_to(:item_related?) }
  it { should respond_to(:private?) }
  it { should belong_to(:creator).class_name(:User) }
end
