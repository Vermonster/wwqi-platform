require 'spec_helper'

describe 'Contribution Edit button', js: true do
  let(:test_item) { create(:item, thumbnail: 'http://s3.amazonaws.com/assets.qajarwomen.org/thumbs/it_3438.jpg?1345647766') }
  let(:test_item_relation) { create(:item_relation, item: test_item)}
  let(:test_user) { create :user }
  let!(:transcription) { create(:transcription, item_relation: test_item_relation, creator: test_user) }

  before do
    sign_in(test_user)
    visit root_path
    click_on 'My Contributions'
    page.find('.item-title').hover
  end
  
  it 'shows edit button' do 
    find_link('Edit').should be_visible
  end

  it 'shows the edit page' do
    click_on 'Edit'

    current_path.should == edit_contribution_path(transcription)
    expect(page).to have_selector("img[src$='#{test_item.thumbnail}']")
    page.find('textarea[id="transcription_details"]').value.should == transcription.details
    expect(page).to have_button('Save changes')
  end

  it 'updates the content' do
    click_on 'Edit'
    page.find('textarea[id="transcription_details"]').set(' -updated- ')
    click_on 'Save changes'

    current_path.should == contribution_path(transcription)
    expect(page).to have_content('Your transcription was successfully updated.')
    expect(page).to have_content(' -updated- ')
  end

  it 'validates' do
    click_on 'Edit'
    page.find('textarea[id="transcription_details"]').set('')
    click_on 'Save changes'

    expect(page).to have_content('Can\'t be blank')
  end
end
