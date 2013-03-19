require 'spec_helper'

describe CommentDecorator do
  let!(:comment1) do
    create(:comment,
           details: 'hello world',
           user: create(:user, first_name: 'Mario'),
           commentable: create(:question),
           created_at: 1.hour.ago)
  end
  
  let!(:comment2) do
    create(:comment,
           details: 'hello world',
           user: create(:user, first_name: 'Bowser'),
           commentable: create(:discussion))
  end

  let!(:c1_decorator) { comment1.decorate }
  let!(:c2_decorator) { comment2.decorate }

  it "has a header" do
    c1_decorator.header.should == "Mario asked"
    c2_decorator.header.should == "Bowser replied"
  end

  it "reports how long ago it was created" do
    c1_decorator.created_ago.should == "about 1 hour ago"
  end
end
