# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :contribution_request, parent: :contribution, class: :ContributionRequest
end
