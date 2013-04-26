# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :post do
    title { generate(:string) }
    details { generate(:string) }
    creator
  
    trait :with_items do
      ignore do
        items_count 3
      end

      after(:build) do |post, evaluator|
        build_list(:item, evaluator.items_count, post_id: post)
      end
    end
  end
end
