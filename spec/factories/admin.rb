FactoryBot.define do
    factory :admin do
        email { 'admin@mail.ru' }
        password { '11111111' }
        password_confirmation { '11111111' }
    end
end
  
