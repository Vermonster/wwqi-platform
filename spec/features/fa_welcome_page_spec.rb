# Encoding: utf-8
require 'spec_helper'

feature 'Persian Welcome page in Persian' do
  before { visit root_path }

  scenario 'shows welcome header and description' do
    expect(page).to have_content('به «پژوهشگاه دنیای زنان در عصر قاجار» خوش آمدی')
    expect(page).not_to have_content('Welcome to the WWQI Research Platform')
  end

  scenario 'shows feature headers' do
    expect(page).to have_content('پرسش و گفتگو') # Question & Discussion
    expect(page).to have_content('پژوهشهای در جریان') # Research in Progress
    expect(page).to have_content('مشارکت') # Contribution   
  end

  scenario 'shows sign up' do
    expect(page).to have_content('ﺚﺒﺗ ﻥﺎﻣ')
    expect(page).to_not have_content('Sign Up')
  end

  scenario 'shows sign in' do
    expect(page).to have_content('ﻭﺭﻭﺩ ﺐﻫ ﺱﺍیﺕ')
    expect(page).to_not have_content('Sign In')
  end

  scenario 'shows a language switch button' do
    expect(page).to have_link('English')
    expect(page).to_not have_content('ﻑﺍﺮﺳی')
  end
end
