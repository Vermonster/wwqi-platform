require 'spec_helper'

describe 'json request' do
  let!(:item) { create(:item, accession_no: '1253A24') }

  # Create multiple activities with an item
  let!(:item_related_questions)            { create_list(:item_relation, 4, item: item) }
  let!(:item_related_discussions)          { create_list(:item_relation, 6, :with_discussion, item: item) }
  let!(:item_related_researches)           { create_list(:item_relation, 2, :with_research, item: item) }
  let!(:item_related_translations)         { create_list(:item_relation, 5, :with_translation, item: item) }
  let!(:item_related_transcriptions)       { create_list(:item_relation, 1, :with_transcription, item: item) }
  let!(:item_related_comments)             { create_list(:item_relation, 7, :with_comment, item: item) }

  # Creating a contribution request is not considered as an activity. Also, it
  # should not change any activity counts.
  let!(:item_related_contribution_request) { create_list(:item_relation, 8, :with_contribution_request, item: item) }

  # Make a request for the activity data in json format
  before { get '/activity/activity_data?accession_no=1253A24', :format => :json }

  it 'receives a success response' do
    expect(response).to be_success
    expect(response.header['Content-Type']).to include 'application/json'
  end

  it 'receives a activity data in json' do
    activity = ActiveSupport::JSON.decode(response.body)

    # Test each activity data are matched as expected
    expect(activity['Question']).to eq 4
    expect(activity['Discussion']).to eq 6
    expect(activity['Research']).to eq 2
    expect(activity['Translation']).to eq 5
    expect(activity['Transcription']).to eq 1
    expect(activity['Comment']).to eq 7
  end

  it 'receives "Not Found" if the item is not found' do

    # Make a request with a wrong accession number
    get '/activity/activity_data?accession_no=1253', :format => :json

    # Test it still receives a success response from the platform
    expect(response).to be_success
    expect(response.header['Content-Type']).to include 'application/json'

    # Test the received json data indicates that the item is not found
    activity = ActiveSupport::JSON.decode(response.body)
    expect(activity['Not Found']).to eq 'Not Found'
  end
end
