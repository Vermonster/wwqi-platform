# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :item_relation do
    item
    association :itemable, factory: :question
  end
end
