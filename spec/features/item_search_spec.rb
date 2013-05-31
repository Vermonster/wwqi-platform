require 'spec_helper'

feature "Cross-platform item search", js: true do
  let(:user) { create(:user) }

  before(:each) do
    visit '/'
    click_on 'Sign in'
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_button 'Sign In'
    visit new_post_path
  end

  describe "selecting an item" do
    it 'associates an item with the post' do
      pending('investigation')
      click_button 'Yes'
      find('.item-group').should be_visible

      page.execute_script %Q{ $('#post_items_attributes_0_search').val('tin').keydown() }
      page.execute_script %Q{ $('.ui-menu-item a:contains("31g171 - Aspirin tin")').trigger("mouseenter").click(); }
      screenshot_and_open_image
    end
  end
end
