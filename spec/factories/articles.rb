FactoryBot.define do
  factory :article do
    title { 'MyString' }
    text { 'MyText' }
    image { Rack::Test::UploadedFile.new(Rails.root.join('spec/factories/images/dog.jpeg'), 'image/jpeg') }
    association :category, factory: :category
    association :admin, factory: :admin
  end
end
