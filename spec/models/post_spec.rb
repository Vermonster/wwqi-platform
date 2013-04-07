require 'spec_helper'

describe Post do
  it { should have_db_column(:type) }
  it { should respond_to(:tag_list) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:details) }
  it { should validate_presence_of(:creator_id) }
  it { should have_many(:uploads).dependent(:destroy) }
  it { should have_many(:comments).dependent(:destroy) }
  it { should have_many(:items).dependent(:destroy) }         # for Item URL
  it { should have_many(:collaborators).dependent(:destroy) } # for Collaborator
  it { should respond_to(:item_related?) }
  it { should respond_to(:private?) }
  it { should belong_to(:creator).class_name(:User) }
  it { should have_many(:followings).dependent(:destroy) }
  it { should have_many(:followers).through(:followings).class_name(:User) }
  it { should accept_nested_attributes_for(:uploads) }
  it { should accept_nested_attributes_for(:items) }          # for Item URL 
  it { should accept_nested_attributes_for(:collaborators) }  # for Collaborator 

  shared_examples "a post" do
    let(:klass) { described_class.to_s.downcase.intern }
    
    it "has a valid factory" do
      build(klass).should be_valid
    end

    describe "ordering" do
      it "has a default ordering of created_at DESC" do
        c1 = create(klass, created_at: Time.zone.today)
        c2 = create(klass, created_at: 2.days.ago)
        c3 = create(klass, created_at: 1.day.ago)

        described_class.all.should == [c1, c3, c2]
      end
    end
  end

  describe Question do
    it_behaves_like "a post"
  end

  describe Discussion do
    it_behaves_like "a post"
  end

  describe Research do
    it_behaves_like "a post"
  end
end
