require 'spec_helper'

describe "research creation" do
  context "without authentication" do
    it "only allows a signed in user to create a new post" do
      visit researches_path
      click_link 'Submit Your Research'

      expect(page).to have_content('You need to sign in or sign up before continuing')
    end
  end

  context "authenticated" do

    let(:user1) { create(:user) }

    before do
      sign_in user1
      visit researches_path
      click_link 'Submit Your Research'
    end

    describe "Submit your research button" do
      it "goes to the new research form" do
        expect(current_path).to eq(new_research_path)
      end
    end

    describe "research creation" do
      it "creates new research" do
        fill_in('Your Research Title', with: 'This is the reserach title?')
        fill_in('Additional Details', with: 'This is the additional details for this reearch')
        click_button('Submit Research')

        expect(current_path).to eq(research_path(1))
        expect(Research.count).to eq 1
        expect(page).to have_content('Research was successfully posted')
        expect(page).to have_content("#{user1.fullname} shared research in progress")
        expect(page).to have_content('This is the reserach title?')
        expect(page).to have_content('This is the additional details for this reearch')

      end
    end
  end
end
