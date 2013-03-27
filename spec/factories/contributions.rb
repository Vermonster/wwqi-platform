# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :contribution do
    details { generate(:string) }
    item
    creator
  end
end
