FactoryGirl.define do
  sequence :email do |n|
    "email#{n}@example.com"
  end

  sequence :string do |n|
    "string#{n}"
  end

  sequence :number do |n|
    n
  end

  sequence :url do |n|
    "http://www.example#{n}.com"
  end
end

