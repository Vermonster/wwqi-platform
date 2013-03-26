require 'spec_helper'

describe PostDecorator do
  let!(:user) do
    user = create(
      :user,
      first_name: 'Mila',
      last_name: 'Kunis',
    )
  end
  
  let!(:question1) do
    create(
      :question,
      title: 'Hello World',
      details: "A brave new world of kitchen appliances.",
      creator: user,
      created_at: 2.days.ago
    )
  end
  
  let!(:question2) do
    create(
      :question,
      title: 'Salutations',
      details: "He was a such a brave toaster.",
      creator: user,
      created_at: 3.days.ago
    )
  end

  let!(:discussion) do
    create(
      :discussion,
      title: 'Goodbye Paradise',
      details: "An adventure waiting around every corner.",
      creator: user,
      created_at: 2.hours.ago
    )
  end

  let!(:research) do
    create(
      :research,
      title: 'Cinema Paradiso',
      details: 'Is a very good movie',
      creator: user,
      created_at: 4.houts.ago
    )
  end

  let!(:comment1) do
    create(
      :comment,
      details: "This is a comment.",
      commentable: question1,
      user: user
    )
  end
  
  let!(:comment2) do
    create(
      :comment,
      details: "This is another comment.",
      commentable: question2,
      user: user
    )
  end
  
  let!(:comment3) do
    create(
      :comment,
      details: "Yet another comment.",
      commentable: question2,
      user: user
    )
  end

  let!(:comment4) do
    create(
      :comment
      details: "Yay! I made a comment.",
      commentable: research,
      user: user
    )
  end

  let!(:q1_decorator) { question1.reload.decorate }
  let!(:q2_decorator) { question2.reload.decorate }
  let!(:d_decorator) { discussion.reload.decorate }
  let!(:r_decorator) { research.reload.decorate }

  it "has a header" do
    q1_decorator.header.should == "Mila asked a question"
    d_decorator.header.should == "Mila started a discussion"
    r_decorator.header.should == "Mila shared research in progress"
  end

  it "has a title" do
    q1_decorator.title.should == "Hello World"
    q2_decorator.title.should == "Salutations"
    d_decorator.title.should == "Goodbye Paradise"
    r_decorator.title.should == "Cinema Paradiso"
  end

  it "reports the number of replies or answers" do
    q1_decorator.comments_received.should == "1 answer"
    q2_decorator.comments_received.should == "2 answers"
    d_decorator.comments_received.should == "no replies"
    r_decorator.comments_received.should == "1 comment"
  end

  it "reports how long ago it was created" do
    q1_decorator.created_ago.should == "2 days ago"
    q2_decorator.created_ago.should == "3 days ago"
    d_decorator.created_ago.should == "about 2 hours ago"
    r_decorator.created_ago.sould == "about 4 hours ago"
  end
end
