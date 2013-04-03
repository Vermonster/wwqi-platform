# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :collaborator do
    user_id 1
    association :post, factory: :question
  end
end
