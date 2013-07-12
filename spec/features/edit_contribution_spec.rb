require 'spec_helper'

describe 'Contribution Edit button', js: true do
  let!(:item) { create(:item, thumbnail: 'http://s3.amazonaws.com/assets.qajarwomen.org/thumbs/it_3438.jpg?1345647766') }
  let!(:item_relation) { create(:item_relation, item: item)}
  let!(:user) { create :user }
  let!(:transcription) { create(:transcription, item_relation: item_relation, creator: user) }

  before(:each) do
    sign_in(user)
    visit my_profile_path
    click_on 'My Contributions'
    page.find('.item-title').hover
  end
  
  after(:each) do
    sign_out
  end

  it 'shows edit button' do 
    find_link('Edit').should be_visible
  end

  it 'shows the edit page' do
    click_on 'Edit'
    current_path.should == edit_contribution_path(transcription)
    expect(page).to have_selector("img[src$='#{item.thumbnail}']")
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
