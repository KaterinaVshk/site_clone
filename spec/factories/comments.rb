FactoryBot.define do
  factory :comment do
    content { "MyString" }
    association :commentable, factory: :article
  end
end
