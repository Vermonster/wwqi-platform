# Encoding: utf-8
require 'spec_helper'
feature 'Language switch', js: true do
  before { visit root_path }

  scenario 'User sees the home page in English at first visit' do
    # Test the language switch button is visible with Persian label
    expect(page).to have_css('.select-farsi')
    expect(page).to have_css('.select-english', visible: false)

    # Test the welcome title in English
    expect(page).to have_content('Welcome to the WWQI Research Platform')
    expect(page).not_to have_content("پژوهشگاه")
  end

  scenario 'User can switch English to Persian' do
    find('.language-select-intro').click

    # Test the language switch button is visible with English label
    expect(page).to have_css('.select-english')
    expect(page).to have_css('.select-farsi', visible: false)

    # Test the welcome title in Persian
    expect(page).to have_content('پژوهشگاه')
    expect(page).not_to have_content('Welcome to the WWQI Research Platform')
  end

  scenario 'English page shows the term requirement link in English' do
    expect(page).to have_link('Please read and accept the terms and conditions.')
  end

  scenario 'Persian page shows the term requirement link in Persian' do
    find('.language-select-intro').click

    expect(page).to have_content('لطفأ مقررات کاربری را مطالعه کرده و موافقت خود را اعلام کنید')
  end

  scenario 'Terms in English shows Persian switch button' do
    click_on 'Please read and accept the terms and conditions.'

    # Test the registration terms in English
    expect(page).to have_content('User Policy')
    expect(page).not_to have_content('مقررات کاربری')

    # Test the language switch button is visible with Perisian label
    expect(page).to have_content('فارسی')
    expect(page).not_to have_content('english')
  end

  scenario 'Terms in Persian shows English switch button' do
    find('.language-select-intro').click
    click_link 'لطفأ مقررات کاربری را مطالعه کرده و موافقت خود را اعلام کنید'

    # Test the registration terms in Persian
    expect(page).to have_content('مقررات کاربری')
    expect(page).not_to have_content('User Policy')

    # Test the language switch button is visible with English label
    expect(page).to have_content('english')
    expect(page).not_to have_content('فارسی')
  end
end
