def fill_in_required_thread_fields
  fill_in 'post_tag_list', with: 'a tag'
  fill_in 'post_title', with: 'a title'
  fill_in 'post_details', with: 'additional details'
end

def fill_in_required_research_fields
  fill_in 'research_tag_list', with: 'a tag'
  fill_in 'research_title', with: 'a title'
  fill_in 'research_details', with: 'additional details'
end

def sign_in_with(email, password)
  visit '/'
  within('#sign-in-main') do
    fill_in 'user_email', with: email
    fill_in 'user_password', with: password
    click_on 'Sign In'
  end
  page.should have_content('Successfully signed in.')
end
