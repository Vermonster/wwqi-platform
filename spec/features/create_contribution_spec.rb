require 'spec_helper'

describe "Contribution creation" do
    context "without authentication" do
      it "only allows a signed in user to create a new contribution" do
        visit new_contribution_path
        current_path.should == new_user_session_path
        expect(page).to have_content("You need to sign in or sign up before continuing.")
      end

      it "user can visit contribution page without authentication" do
        visit contributions_path
        expect(page).to have_content('Help us enrich the WWQI archives.')
        expect(page).to have_content('Items in need of transcription')
      end
    end

  context "with a selected item", js: true do
    let!(:test_item) { create(:item,
                              url: "/en/items/1016A200.html",
                              name: "Infant headband",
                              thumbnail: "http://s3.amazonaws.com/assets.qajarwomen.org/thumbs/it_200.jpg?1329177600",
                              accession_no: "1016A200") }
    let(:user) { create(:user) }

    before { sign_in(user) }

    it "creates a new transcription" do
      create_and_check_contribution('Transcription', test_item)
    end

    it "creates a new transcrption with a document upload" do
      create_and_check_contribution('Transcription', test_item, true)
    end

    it "creates translation creation" do
      create_and_check_contribution('Translation', test_item)
    end

    it "creates a new translation with a document upload" do
      create_and_check_contribution('Translation', test_item, true)
    end

    # Helper to test each contribution type
    def create_and_check_contribution(type, selected_item, test_upload=false)
      visit new_contribution_path(type: type, item: selected_item)
      expect(page).to have_content("You are submitting a #{type.downcase} for: #{selected_item.name}")

      page.execute_script("editor.setValue('Contribution test')")

      if test_upload
        # Since the file field doesn't have a label, attach_file can't not
        # be used. Instead, the file path is stored manually.
        click_on 'Add Upload'
        page.execute_script("$('.file.optional.upload').toggle();")
        find(".input.file.optional.#{type.downcase}_uploads_content").find('input').set("#{Rails.root}/spec/support/Montmarte.jpg")
      end

      click_button "Submit #{type.titleize}"
    end

    def check_contribution(type, selected_item=nil, test_upload=false)

      Contribution.count.should == 1
      contribution = Contribution.last
      current_path.should == contribution_path(contribution)
      expect(page).to have_content("Contribution test")

      if selected_item
        ItemRelation.count.should == 1
        expect(page).to have_content(selected_item.name)
        expect(page).to have_selector("img[src$='#{selected_item.thumbnail}']")
      end

      if test_upload
        expect(page).to have_content('Attached Documents')
        expect(page).to have_content('Montmarte.jpg')
      end

      visit contributions_path(type: type)
      expect(page).to have_content("#{user.fullname} contributed a #{type.downcase} ")
      expect(page).to have_content("for #{selected_item.name}") if selected_item
    end
  end
end
