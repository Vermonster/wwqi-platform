FactoryGirl.define do
  factory :correction, parent: :contribution, class: :Correction do
    item
  end
end

