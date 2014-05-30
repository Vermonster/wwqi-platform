require 'spec_helper'

describe 'icons on welcome page', js: true do

  before do
    visit root_path
  end

  it 'redirects to Question & Discussions when Q & D icon clicked' do
    find('.question-discussion-feature').click

    expect(current_path).to eq '/threads'
  end

  it 'redirects to Researchs when Research icon clicked' do
    find('.research-feature').click

    expect(current_path).to eq '/researches'
  end

  it 'redirect to Contributions when Contributions icon clicked' do
    find('.contribution-feature').click

    expect(current_path).to eq '/contributions'
  end
end
