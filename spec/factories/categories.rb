FactoryBot.define do
  categories = %w[people opinions auto technologies realty]
  sequence(:id) { |n| n }
  factory :category do
    name { categories.shift }
    id
  end
end
