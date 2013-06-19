require 'spec_helper'

describe Contribution do
  it { should have_db_column(:type) }
  it { should validate_presence_of(:details) }
  it { should validate_presence_of(:creator_id) }
  it { should belong_to(:creator).class_name(:User) }
  it { should have_many(:uploads).dependent(:destroy) }
  it { should accept_nested_attributes_for(:uploads) }
  it { should have_many(:comments).dependent(:destroy) }
  it { should have_one(:item_relation).dependent(:destroy) }
  it { should have_one(:item).through(:item_relation) }
  it { should have_many(:followings).dependent(:destroy) }
  it { should have_many(:followers).through(:followings) }

  shared_examples "a contribution" do
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

  describe Transcription do
    it_behaves_like "a contribution"
  end

  describe Translation do
    it_behaves_like "a contribution"
  end

  describe Biography do
    it_behaves_like "a contribution"
  end

  describe Correction do
    it_behaves_like "a contribution"
  end
  
  describe ContributionRequest do
    it_behaves_like "a contribution"
  end
end
