# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :post do
    title { generate(:string) }
    details { generate(:string) }
    creator
    factory :post_with_invitations do
      ignore do
        number_of_invitations 3
      end

      after :create do |post, evaluator|
        FactoryGirl.create_list :invitation, evaluator.number_of_invitations, post: post
      end
    end
  end
end
