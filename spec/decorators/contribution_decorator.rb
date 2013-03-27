require 'spec_helper'

describe ContributionDecorator do
  let!(:user) do
    user = create(
      :useer,
      first_name: 'Ted'
    )
  end

  let!(:transcription) do
    create(
      :transcription,
      details: 'A transcription',
      creator: user,
      created_at: 2.days.ago
    )
  end
  
  let!(:translation) do
    create(
      :translation,
      details: 'A translation',
      creator: user,
      created_at: 3.day.ago
    )
  end
  
  let!(:biography) do
    create(
      :biography,
      details: 'A biography',
      creator: user,
      created_at: 4.days.ago
    )
  end
  
  let!(:correction) do
    create(
      :correction,
      details: 'A correction',
      creator: user,
      created_at: 5.days.ago
    )
  end

  let!(:comment) do
    create(
      :comment,
      details: 'A comment',
      commentable: transcription,
      user: user
    )
  end

  let!(:transl_decorator) { translation.reload.decorate }
  let!(:transc_decorator) { transcription.reload.decorate }
  let!(:bio_decorator) { biography.reload.decorate }
  let!(:corr_decorator) { correction.reload.decorate }

  it "has a header" do
    trans1_decorator.header.should == "Ted contributed a translation for"
    transc_decorator.header.should == "Ted contributed a transcription for"
    bio_decorator.header.should == "Ted contributed a biography for"
    corr_decorator.header.should == "Ted contributed a correction for"
  end
  
  it "has a title" do
    trans1_decorator.title.should == "A translation"
    transc_decorator.title.should == "A transcription"
    bio_decorator.title.should == "A biography"
    corr_decorator.title.should == "A correction"
  end
  
  it "reports the number of comments" do
    trans1_decorator.comments_received.should == "no comments"
    transc_decorator.comments_received.should == "1 comment"
  end
end
