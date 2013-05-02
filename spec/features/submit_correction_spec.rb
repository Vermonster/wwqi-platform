require 'spec_helper'

describe "submit correction" do
  let!(:user) do
    create(:user)
  end
  
  let!(:correction) do
    create(:correction, creator: user)
  end
  
  describe "corrections" do
    it "lets registered users submit corrections" do
      sign_in(user)
      
      visit new_correction_path
      
      fill_in 'correction_item_id', with: correction.item_id
      fill_in 'correction_details', with: "Fix line 2."
      click_on 'Submit Correction'
      
      page.should have_content(correction.item_id)
      page.should have_content('Your correction was successfully submitted.')
      
      sign_out
    end
    
    it "lets unregistered users submit corrections" do
      visit new_correction_path
      
      fill_in 'correction_item_id', with: correction.item_id
      fill_in 'correction_details', with: "Fix line 3."
      click_on 'Submit Correction'
      
      current_path.should == contributions_path
      page.should have_content('Your correction was successfully submitted.')
    end
  end
  
end