require 'spec_helper'

describe 'Activity Request' do
  let(:item) { create(:item,
                       accession_no: '31g166',
                       thumbnail: 'http://s3.amazonaws.com/assets.qajarwomen.org/thumbs/it_2387.jpg?1329177600',
                       name: 'Ewer'
                      ) }
  let(:user) { create(:user) }

  it 'redirects to the related question list' do
    # Create 5 questions with the item and 3 questions without the item
    create_list(:item_relation, 5, item: item)
    create_list(:item_relation, 3)
    visit '/threads?type=Question&accession_no=31g166'

    # Test there are only questions related to the item showing on the page
    expect(page).to have_content('question')
    expect(page).not_to have_content('discussion')
    expect(page).to have_css('.item-header', count: 5)
  end

  it 'redirects to the related discussion list' do
    # Create 3 discussions with the item and 7 discussions without the item
    create_list(:item_relation, 3, :with_discussion, item: item)
    create_list(:item_relation, 7, :with_discussion)
    visit '/threads?type=Discussion&accession_no=31g166'

    # Test there are only discussions related to the item showing on the page
    expect(page).to have_content('discussion')
    expect(page).not_to have_content('question')
    expect(page).to have_css('.item-header', count: 3)
  end

  it 'redirects to the related research list' do
    # Create 9 researches with the item and 3 researches without the item
    create_list(:item_relation, 9, :with_research, item: item)
    create_list(:item_relation, 3, :with_research)
    visit '/researches?accession_no=31g166'

    # Test there are only resesearches related to the item showing on the page
    expect(page).to have_content('research in progress')
    expect(page).to have_css('.item-header', count: 9)
  end

  it 'redirects to the related translation list' do
    # Create 2 translations with the item
    create_contribution('Translation', item, 2)
    visit '/contributions?type=Translation&accession_no=31g166'

    expect(page).to have_content('contributed a translation for')
    expect(page).to have_css('a', text: item.name, count: 2)
  end

  it 'redirects to the related transcription list' do
    # Create 4 transcriptions with the item
    create_contribution('Transcription', item, 4)
    visit '/contributions?type=Transcription&accession_no=31g166'

    expect(page).to have_content('contributed a transcription for')
    expect(page).to have_css('a', text: item.name, count: 4)
  end

  it 'redirects to the related biography list' do
    visit '/contributions?type=Biography&accession_no=31g166'

    expect(page).to have_content('No recent contributions')
    expect(page).not_to have_css('a', text: item.name)
  end

  def create_contribution(type, selected_item, repeat)
    sign_in(user)
    repeat.times do
      visit new_contribution_path(type: type, item: selected_item)
      fill_in "#{type.downcase}_details", with: "Transcription Test"
      click_on "Submit #{type.titleize}"
    end
    sign_out
  end

  it 'redirects to the root page if the item is not found' do
    visit '/threads?type=discussion&accession_no=31g6'

    expect(page).to have_content('Missing item')
    expect(page).not_to have_content('question')
    expect(page).not_to have_content('discussion')
    expect(page).not_to have_content('research')
  end
end
