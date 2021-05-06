FactoryBot.define do
  factory :preference do
    comment_id { 1 }
    user_id { 1 }
    type { 'Like' }
  end
end
