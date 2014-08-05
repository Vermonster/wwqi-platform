require 'spec_helper'

describe 'Biographies', js: true do
  let(:user) { create :user }

  it 'asks to sign in to write a biography' do
    visit '/contributions/new?type=Biography&first_name=john&last_name=smith&person_id=5'

    expect(page).to have_content('You need to sign in or sign up before continuing.')
  end

  it 'new biography page must have the url to the person page on cms' do
    sign_in(user)
    visit '/contributions/new?type=Biography&name=john%20smith&person_id=5'

    expect(page).to have_link('John Smith', href: "#{ENV['WWQI_SITE']}/en/people/5.html")
    # this expectation is no longer true because placeholder image is used if the target image is not found on S3
    # expect(page).to have_selector(%Q(img[src$="#{ENV['WWQI_PERSON_THUMBNAIL']}/person_5.jpg"]))
    expect(page).to have_content("John Smith")
  end

  it 'submits new biography' do
    sign_in(user)
    visit '/contributions/new?type=Biography&name=john%20smith&person_id=5'
    page.execute_script("editor.setValue('Biography test')")
    click_on 'Add Upload'

    page.execute_script("$('.file.optional.upload').toggle();")
    find(".input.file.optional.biography_uploads_content").find('input').set("#{Rails.root}/spec/support/Montmarte.jpg")
    click_button 'Submit Biography'

    expect(page).to have_content("Biography test")
    expect(page).to have_link("John Smith", href: "#{ENV['WWQI_SITE']}/en/people/5.html")
    expect(page).to have_content('Attached Documents')
    expect(page).to have_content('Montmarte.jpg')

    visit contributions_path(type: 'Biography')

    expect(page).to have_content("#{user.fullname} contributed a biography for John Smith")

    # this expectation is no longer true because placeholder image is used if the target image is not found on S3
    # expect(page).to have_selector(%Q(img[src$="#{ENV['WWQI_PERSON_THUMBNAIL']}/person_5.jpg"]))

    expect(page).to have_selector(%Q(img[src$="/assets/noimage.jpg"]))

    # check that the created biography shows up on the user's activity feed
    visit my_profile_path

    expect(page).to have_content("#{user.fullname} contributed a biography for John Smith")

  end

  it 'edits a saved biography' do
    sign_in(user)
    visit root_path
    click_on 'Contributions'
    click_on 'Write a biography'

    click_on 'Add New'

    fill_in 'Person Name', with: 'Sadiqah Dawlatabadi'
    fill_in 'Person URL', with: "#{ENV['WWQI_SITE']}/en/people/107.html"
    page.execute_script("editor.setValue('Test biography')")
    click_on 'Submit Biography'

    click_on 'My Profile'
    click_on 'My Contributions'
    page.find('.item-title').hover
    click_on 'Edit'

    page.find('textarea', visible: false).value.should == 'Test biography'

    page.execute_script("editor.setValue('Updated biography')")
    click_on 'Save changes'

    expect(page).to have_content 'Updated biography'
  end
end

