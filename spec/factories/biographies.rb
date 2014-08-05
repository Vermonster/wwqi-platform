FactoryGirl.define do
  factory :biography do
    person_url 'http://www.qajarwomen.org/en/people/105.html'
    person_name { generate(:string) }
    details { generate(:string) }
    creator
  end
end
