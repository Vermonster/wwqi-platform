# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    first_name "Meg"
    last_name "Broughton"
    email "meg@vermonster.com"
    password "password"
    password_confirmation "password"
  end
end
