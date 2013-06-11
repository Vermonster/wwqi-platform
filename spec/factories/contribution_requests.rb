# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :contribution_request do
    accession_number "MyString"
    type ""
    creator_id 1
  end
end
