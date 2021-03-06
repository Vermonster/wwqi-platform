# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :item_relation do
    item
    accession_no { item ? item.accession_no : generate(:string) }

    trait :with_discussion do
      association :itemable, factory: :discussion
    end

    trait :with_research do
      association :itemable, factory: :research
    end

    trait :with_translation do
      association :itemable, factory: :translation
    end

    trait :with_transcription do
      association :itemable, factory: :transcription
    end

    trait :with_biography do
      association :itemable, factory: :biography
    end

    trait :with_comment do
      association :itemable, factory: :comment
    end

    trait :with_contribution_request do
      association :itemable, factory: :contribution_request
    end

    after(:build) do |ir|
      ir.itemable = create(:question) if ir.itemable.nil?
    end
  end
end
