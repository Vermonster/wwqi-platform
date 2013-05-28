# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :item_relation do
    association :itemable, factory: :question
    item
  end
end
