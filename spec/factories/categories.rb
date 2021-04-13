FactoryBot.define do
  sequence(:id) { |n| n -1 }
  factory :category do
    name { 'people' }
    id
  end
end
