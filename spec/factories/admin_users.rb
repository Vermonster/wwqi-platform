# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :admin_user do
    first_name { generate(:string) }
    last_name { generate(:string) }
    email { generate(:email) }
    password "password"
    password_confirmation "password"
  end
end
