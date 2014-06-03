# Encoding: utf-8
require 'spec_helper'

feature 'Navigation in Persian' do
  before { visit root_path(locale: 'fa') }

  scenario 'shows top nav bar in persian' do
    expect(page).to have_content('ییی')
    expect(page).not_to have_content /WWQI Archive/i
  end

end