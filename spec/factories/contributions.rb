# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :contribution do
    details { generate(:string) }
    creator

    after(:build) do |contribution, evaluator|
      contribution.item_relation = build(:item_relation)
    end
  end
end
