# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :comment do
    details { generate(:string) }
    association :commentable, factory: :question
    user
  end
end
