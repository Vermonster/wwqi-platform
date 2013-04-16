# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :invitation do
    recipient_name { generate(:string) }
    recipient_email { generate(:email) }
    message { generate(:string) }
    association :inviter, factory: :user
  end
end
