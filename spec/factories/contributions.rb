# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :contribution do
    details { generate(:string) }
    creator

    after(:create) do |contribution, evaluator|
      create(:item, itemable: contribution)
    end
  end
end
