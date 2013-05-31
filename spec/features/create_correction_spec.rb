require 'spec_helper'

describe "creating corrections" do
  context "unregistered users" do
    it "can submit corrections", js: true do
      visit new_correction_path
      
      page.execute_script %Q{ $('#correction_item_relation_attributes_search').val('tin').keydown(); }
      expect { find('.ui-menu-item a#ui-id-2').text == "31g171 - Aspirin tin" }.to become_true
      page.execute_script %Q{ $('.ui-menu-item a:contains("31g171 - Aspirin tin")').click(); }
      expect { find('#correction_item_relation_attributes_search').value == '31g171 - Aspirin tin' }.to become_true
      page.execute_script("editor.setValue('Hello world')")
      click_on 'Submit Correction'
     
      current_path.should == contributions_path
      page.should have_content('Your correction was successfully submitted.')
    end
  end

  context "registered users" do
    it "can submit corrections", js: true do
      user = create(:user)
      visit '/'
      click_on 'Sign in'
      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password
      click_button 'Sign In'
      
      visit new_correction_path
      
      page.execute_script %Q{ $('#correction_item_relation_attributes_search').val('tin').keydown(); }
      expect { find('.ui-menu-item a#ui-id-2').text == "31g171 - Aspirin tin" }.to become_true
      page.execute_script %Q{ $('.ui-menu-item a:contains("31g171 - Aspirin tin")').click(); }
      expect { find('#correction_item_relation_attributes_search').value == '31g171 - Aspirin tin' }.to become_true
      page.execute_script("editor.setValue('Hello world')")
      click_on 'Submit Correction'
      
      current_path.should == contributions_path
      page.should have_content('Your correction was successfully submitted.')
    end
  end
end
