require 'spec_helper'

describe Post do
  it { should have_db_column(:type) }
  it { should respond_to(:tag_list) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:details) }
  it { should validate_presence_of(:creator_id) }
  it { should have_many(:uploads).dependent(:destroy) }
  it { should have_many(:comments).dependent(:destroy) }
  it { should have_many(:item_relations) }
  it { should have_many(:items).through(:item_relations) }
  it { should have_many(:collaborators).dependent(:destroy) }
  it { should respond_to(:item_related?) }
  it { should respond_to(:private?) }
  it { should belong_to(:creator).class_name(:User) }
  it { should have_many(:followings).dependent(:destroy) }
  it { should have_many(:followers).through(:followings).class_name(:User) }
  it { should accept_nested_attributes_for(:uploads) }
  it { should accept_nested_attributes_for(:item_relations) }
  it { should accept_nested_attributes_for(:collaborators) }

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

    describe "items" do
      it "does not create items when item_related is false" do
        user = create(:user)
        attrs = attributes_for(klass, item_related: false).merge({
          :item_relations_attributes => [
            attributes_for(:item_relation).merge(
              :url => 'waa',
              :thumbnail => 'waa',
              :name => 'waa',
              :accession_no => 'waa'
            )
        ]})
        post = described_class.new(attrs)
        post.creator_id = user.id
        post.save

        post.items.should be_empty
      end

      it "creates items when item_related is true" do
        user = create(:user)
        attrs = attributes_for(klass, item_related: true).merge({
          :item_relations_attributes => [
            attributes_for(:item_relation).merge(
              :url => 'waa',
              :thumbnail => 'waa',
              :name => 'waa',
              :accession_no => 'waa'
            )
        ]})
        post = described_class.new(attrs)
        post.creator_id = user.id
        post.save

        post.items.should_not be_empty
      end
    end
    
    describe "collaborators" do
      it "does not create collaborators when private is false" do
        user = create(:user)
        attrs = attributes_for(klass, private: false).merge({
          :collaborators_attributes => [
            attributes_for(:collaborator).merge({
              :user_id => user.id
            })
        ]})
        post = described_class.new(attrs)
        post.creator_id = user.id
        post.save

        post.collaborators.should be_empty
      end

      it "creates collaborators when private is true" do
        user = create(:user)
        attrs = attributes_for(klass, private: true).merge({
          :collaborators_attributes => [
            attributes_for(:collaborator).merge({
              :user_id => user.id
            })
        ]})
        post = described_class.new(attrs)
        post.creator_id = user.id
        post.save

        post.collaborators.should_not be_empty
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

  describe "aggregation" do
    it "returns a collection of questions and discussions only" do
      question = create(:question)
      discussion = create(:discussion)
      research = create(:discussion)

      Post.questions_and_discussions =~ [question, discussion]
    end
  end
end
