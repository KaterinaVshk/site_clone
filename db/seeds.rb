Admin.create({ email: ENV['ADMIN_EMAIL'], password:  ENV['ADMIN_PASSWORD'] })
Article::CATEGORY_MAP.each_pair do |key,value|
  Category.find_or_create_by(name: key)
end
50.times do 
  User.create({email: Faker::Internet.email, password: Faker::Internet.password, first_name: Faker::Name.name})
end
