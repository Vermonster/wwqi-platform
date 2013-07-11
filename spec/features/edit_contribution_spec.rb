require 'spec_helper'

describe 'Contribution Edit button', js: true do
  let(:user) { create :user }
  let!(:transcription) { create(:transcription, creator: user) }

  before do
    sign_in(user)
    visit my_profile_path
    click_on 'My Contributions'
  end

  it 'shows edit button' do 
    expect(page).to have_content(transcription.item_relation.name)
    page.find('.item-title').hover
    find_link('Edit').should be_visible
  end

  it 'shows the edit page' do
    page.find('.item-title').hover
    click_on 'Edit'
    current_path.should == edit_contribution_path(transcription)
  end
end
