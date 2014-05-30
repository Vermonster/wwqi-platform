# Encoding: utf-8
require 'spec_helper'

feature 'Sign-in and Sign-up form shows Persian messages', js: true do
  let(:user) { create(:user) }
  before { visit root_path(locale: 'fa') }

  scenario 'for required fields' do
    find('.checkbox').click
    click_on 'Sign Up'
    sleep 3

    # Can't be blank in Persian
    expect(page).to have_css('.error', count: 4, text: '.این میدان نمی تواند خالی باشد')
  end

  scenario 'when the email exists on the system already' do
    fill_in 'sign_up_user_email', with: user.email
    click_on 'Sign Up'
    sleep 3

    # Has already been taken in Persian
    expect(page).to have_css('.error', text: '.از این رمز استفاده شده. عبارت دیگری انتخاب کنی')
  end

  scenario 'for unmatched password' do
    fill_sign_up('Andrews', 'Ross', 'aross@test.com', 'aross', 'andrewsross', true)
    click_on 'Sign Up'
    sleep 3

    # Doesn't match confirmation in Persian
    expect(page).to have_css('.error', text: '.تکرار با اصل مطابقت ندارد')
  end

  scenario 'the user registration aggrement has been ignored' do
    fill_sign_up('Andrews', 'Ross', 'aross@test.com', 'aross', 'aross', false)
    click_on 'Sign Up'
    sleep 3

    # Must be accepted in Persian
    expect(page).to have_css('.error', text: '.توافق شما الزامی است')
  end

  scenario 'when a user signs in with invalid email or password' do
    fill_sign_in(user.email, 'pass')
    click_on 'Sign In'
    sleep 3

    # Invalid email or password in Persian
    expect(page).to have_css('.alert.alert-error', exact: true, text: 'ایمیل یا رمز عبور غیر معتبر')
  end

  scenario 'when a user signs in successfully' do
    fill_sign_in(user.email, user.password)
    click_on 'Sign In'
    sleep 3

    # Signed in successfully in Persian
    expect(page).to have_css('.alert', text: 'ورود موفق')
  end

  scenario 'when a user signs out successfully' do
    fill_sign_in(user.email, user.password)
    click_on 'Sign In'
    sleep 3
    click_on 'Sign out'

    # Signed out successfully in Persian
    expect(page).to have_css('.alert', text:'خروج موفق')
  end

  scenario 'for invalid email format' do
    fill_sign_up('Andrews', 'Ross', 'aross.com', 'aross', 'aross', true)
    click_on 'Sign Up'
    sleep 3

    # Is invalid in Persian
    expect(page).to have_css('.error', text: '.قابل قبول نیست')
  end
 
  def fill_sign_up(first_name, last_name, email, password, password_confirmation, accept)
    within('#registration') do
      fill_in 'نام', with: first_name, match: :first
      fill_in 'نام خانوادگی', with: last_name
      fill_in 'ایمیل', with: email
      fill_in 'رمز ورود', with: password, match: :first
      fill_in 'تکرار رمز ورود', with: password_confirmation
      find('.checkbox').click if accept
    end
  end

  def fill_sign_in(email, password)
    within('#sign-in') do
      fill_in 'ایمیل', with: email
      fill_in 'رمز ورود', with: password
    end
  end
end
