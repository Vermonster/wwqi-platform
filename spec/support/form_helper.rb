def fill_in_required_post_fields
  fill_in 'post_tag_list', with: 'a tag'
  fill_in 'post_title', with: 'a title'
  fill_in 'post_details', with: 'additional details'
end

def sign_in_with(email, password)
  visit '/'
  within('#login-main') do
    fill_in 'user_email', with: email
    fill_in 'user_password', with: password
    click_on 'Log In'
  end
  #page.save_screenshot('error.png', full: true)
  page.should have_content('Successfully signed in.')
end
