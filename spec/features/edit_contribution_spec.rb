require 'spec_helper'

describe 'Contribution Edit button', js: true do
  # Create a test contribution with an item and a user
  let(:test_item) { create(:item, thumbnail: 'http://s3.amazonaws.com/assets.qajarwomen.org/thumbs/it_3438.jpg?1345647766') }
  let(:test_item_relation) { create(:item_relation, item: test_item)}
  let(:test_user) { create :user }
  let!(:transcription) { create(:transcription, item_relation: test_item_relation, creator: test_user) }

  before do
    sign_in(test_user)
    visit root_path
    click_on 'My Contributions'
    page.find('.item-title').hover
    click_on 'Edit'
  end

  it 'shows edit button' do
    # Go back to the My Contributions page to test the edit button appears
    visit root_path
    click_on 'My Contributions'
    page.find('.item-title').hover

    find_link('Edit').should be_visible
  end

  it 'shows the edit page' do
    # Test the edit page shows buttons and the contribution text stored with the
    # test item
    current_path.should == edit_contribution_path(transcription)
    expect(page).to have_selector("img[src$='#{test_item.thumbnail}']")
    page.find('textarea[id="transcription_details"]', visible: false).value.should == transcription.details
    expect(page).to have_button('Save changes')
  end

  it 'updates the content' do
    # Test the contribution text is editable
    page.execute_script("editor.setValue(' -updated- ')")
    click_on 'Save changes'

    current_path.should == contribution_path(transcription)
    expect(page).to have_content('Your transcription was successfully updated.')
    expect(page).to have_content(' -updated- ')
  end

  it 'validates' do
    # Test the edit page validates the edited text
    page.execute_script("editor.setValue('')")
    click_on 'Save changes'

    expect(page).to have_content('Can\'t be blank')
  end

  it 'allows a user add a file' do
    click_on 'Add Upload'
    page.execute_script("$('.file.optional.upload').toggle();")
    find(".input.file.optional.transcription_uploads_content").find('input').set("#{Rails.root}/spec/support/Montmarte.jpg")
    click_on "Save changes"

    current_path.should == contribution_path(transcription)
    expect(page).to have_content('Your transcription was successfully updated.')
    expect(page).to have_content(transcription.details)
    expect(page).to have_content('Attached Documents')
    expect(page).to have_content('Montmarte.jpg')
  end
end
