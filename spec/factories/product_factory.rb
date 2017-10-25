FactoryGirl.define do
  sequence(:id) { |n| "#{n}" }

  factory :product do
    id
    name "ex"
    description "ttt"
    price 100
    color "blue"
  end

end