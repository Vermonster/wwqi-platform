require 'spec_helper'

describe ContributionDecorator do
  let!(:user) do
    user = create(
      :user,
      first_name: 'Ted',
      last_name: 'Williams'
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

  # Comment feature for Contribution is not implemented yet.

  # let!(:comment) do
  #   create(
  #     :comment,
  #     details: 'A comment',
  #     commentable: transcription,
  #     user: user
  #   )
  # end

  let!(:contribution_request) do
    create(
      :contribution_request,
      details: 'Translation',
      creator: user,
      created_at: 6.days.ago
    )
  end

  let!(:transl_decorator) { translation.reload.decorate }
  let!(:transc_decorator) { transcription.reload.decorate }
  let!(:bio_decorator) { biography.reload.decorate }
  let!(:corr_decorator) { correction.reload.decorate }
  let!(:request_decorator) { contribution_request.reload.decorate }

  it "has a header" do
    transl_decorator.header.should == "Ted Williams contributed a translation for"
    transc_decorator.header.should == "Ted Williams contributed a transcription for"
    bio_decorator.header.should == "Ted Williams contributed a biography for"
    corr_decorator.header.should == "Ted Williams contributed a correction for"
    request_decorator.header.should == "Ted Williams made a Translation request for"
  end
  
  it "has a title" do
    # Titles should be "Not Found" here since the test items are randomly
    # generated. The randomly generated items are not a real item. So, our search
    # can not locate them. 
    transl_decorator.title.should == "Not Found"
    transc_decorator.title.should == "Not Found"
    bio_decorator.title.should == "Not Found"
    corr_decorator.title.should == "Not Found"
    request_decorator.title.should == "Not Found"
  end
  
  # it "reports the number of comments" do
  #   transl_decorator.comments_received.should == "no comments"
  #   transc_decorator.comments_received.should == "1 comment"
  # end
end
