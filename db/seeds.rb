Admin.create({ email: ENV['ADMIN_EMAIL'], password:  ENV['ADMIN_PASSWORD'], password_confirmation:  ENV['ADMIN_PASSWORD_CONFIRM'] })
Article::CATEGORY_MAP.each_pair do |key,value|
  Category.find_or_create_by(name: key)
end
