require 'spec_helper'

describe "Contribution creation" do
  context "with a selected item" do
    before :all do
      @test_item = 
        FactoryGirl.create(
          :item, 
          url: "http://www.qajarwomen.org/en/items/1016A200.html", 
          name: "Infant headband", 
          thumbnail: "http://s3.amazonaws.com/assets.qajarwomen.org/thumbs/it_200.jpg?1329177600", 
          accession_no: "1016A200")
    end
    after :all do 
      @test_item.delete
    end

    describe "without authentication" do
      it "only allows a signed in user to create a new contribution" do
        visit new_contribution_path
        current_path.should == root_path
        expect(page).to have_content("You need to sign in or sign up before continuing.")
      end
      
      it "user can visit contribuion page without authentication" do
        visit contributions_path
        expect(page).to have_content('Help us enrich the WWQI archives by contributing information to the project.')
        expect(page).to have_content('Items in need of Transcription')
        expect(page).to have_content(@test_item.name)
        expect(page).to have_selector("img[src$='#{@test_item.thumbnail}']")
      end
    end

    context "authenticated" do 
      let(:user) { create(:user) }
      before { sign_in(user) }
      after { sign_out }

      describe "transcription creation" do 
        it "creates a new transcription" do
          create_and_check_contribution('Transcription', @test_item)
        end

        it "translation creation" do
          create_and_check_contribution('Translation', @test_item)
        end

        it "biography creation" do
          create_and_check_contribution('Biography', @test_item)
        end

        # Helper to test each contribution type
        def create_and_check_contribution(type, selected_item)
          visit new_contribution_path(type: type, item: selected_item)
          expect(page).to have_content("You are submitting a #{type.downcase} for: #{selected_item.name}")

          fill_in "#{type.downcase}_details", with: "Contribution test"
          click_on "Submit #{type.titleize}"

          Contribution.count.should == 1
          contribution = Contribution.last
          current_path.should == contribution_path(contribution)
          ItemRelation.count.should == 1
          expect(page).to have_content(selected_item.name)
          expect(page).to have_selector("img[src$='#{selected_item.thumbnail}']")
          expect(page).to have_content("Contribution test")

          visit contributions_path(type: type)
          expect(page).to have_content("#{user.fullname} contributed a #{type.downcase} for #{selected_item.name}")
        end
      end
    end
  end
end
