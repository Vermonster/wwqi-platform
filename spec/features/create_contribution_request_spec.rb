require 'spec_helper'

describe 'Contribution request creation' do
  @test_accesssion_no = "1144A1"
  let(:admin) { create(:user, is_admin: true) }

  it 'An admin user can see the admin panel link' do 
    sign_in(admin)
    visit contributions_path
    expect(page).to have_content("Admin Panel")
  end

  it 'A user can not see the admin panel link' do
    user = create(:user)
    visit contributions_path
    expect(page).not_to have_content("Admin Panel")
  end

  it 'An admin user can submit a request', js: true do
    sign_in(admin)
    visit admin_contribution_requests_path
    find_link('New Contribution Request').visible?

    click_on('New Contribution Request')
    current_path.should == new_admin_contribution_request_path
    
    page.execute_script %Q{ $('#contribution_request_item_relation_attributes_search').val('tin').keydown(); }
    expect { find('.ui-menu-item a#ui-id-2').text == "31g171 - Aspirin tin" }.to become_true
    page.execute_script %Q{ $('.ui-menu-item a:contains("31g171 - Aspirin tin")').click(); }
    expect { find('#contribution_request_item_relation_attributes_search').value == '31g171 - Aspirin tin' }.to become_true
    select('Transcription', from: 'Request Type')
    click_on 'Create Contribution request'

    expect(page).to have_content('Contribution request was successfully created.')
    expect(page).to have_content('Transcription')
    expect(page).to have_content(admin.email)
    ContributionRequest.count.should == 1
    last_request = ContributionRequest.last
    current_path.should == admin_contribution_request_path(last_request)
    ItemRelation.count.should == 1
  end
end
