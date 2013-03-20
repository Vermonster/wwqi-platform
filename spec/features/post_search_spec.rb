require 'spec_helper'

describe "post search" do
  before do
    create(:question,
           title: 'Hello World',
           details: 'Something',
           tag_list: 'alpha')

    create(:discussion,
           title: 'Goodbye Cruel World',
           details: 'Another',
           tag_list: 'beta')
  end

  describe "searching for a post" do
    it "searches on title, details, and tags" do
      visit posts_path

      page.should have_content('Hello World')
      page.should have_content('Goodbye Cruel World')

      within('#post_search') do
        fill_in 'q', with: 'hello'
        click_on 'Search'
      end

      page.should have_content('Hello World')
      page.should_not have_content('Goodbye Cruel World')

      within('#post_search') do
        fill_in 'q', with: 'another'
        click_on 'Search'
      end

      page.should have_content('Goodbye Cruel World')
      page.should_not have_content('Hello World')


      within('#post_search') do
        fill_in 'q', with: 'alpha'
        click_on 'Search'
      end

      page.should_not have_content('Goodbye Cruel World')
      page.should have_content('Hello World')
    end
  end
end
