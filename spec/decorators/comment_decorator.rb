require 'spec_helper'

describe CommentDecorator do
  let!(:comment1) do
    create(:comment,
           details: 'hello world',
           user: create(:user, first_name: 'Mario', last_name: 'Smith'),
           commentable: create(:question),
           created_at: 1.hour.ago)
  end
  
  let!(:comment2) do
    create(:comment,
           details: 'hello world',
           user: create(:user, first_name: 'Bowser', last_name: 'Smith'),
           commentable: create(:discussion))
  end

  let!(:comment3) do
    create(:comment,
           details: 'hello world',
           user: create(:user, first_name:'Alan', last_name: 'Parson'),
           commentable: create(:translation),
           created_at: 2.hour.ago
          )
  end

  let!(:c1_decorator) { comment1.decorate }
  let!(:c2_decorator) { comment2.decorate }
  let!(:c3_decorator) { comment3.decorate }

  it "has a header" do
    c1_decorator.header.should == "Mario Smith replied"
    c2_decorator.header.should == "Bowser Smith replied"
    c3_decorator.header.should == "Alan Parson commented"
  end

  it "reports how long ago it was created" do
    c1_decorator.created_ago.should == "about 1 hour ago"
    c3_decorator.created_ago.should == "about 2 hours ago"
  end
end
