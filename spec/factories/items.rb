# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :item do
    url { generate(:url) }
    name { generate(:string) }
    association :post, factory: :question
  end
end
