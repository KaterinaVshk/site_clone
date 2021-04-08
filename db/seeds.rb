CATEGORIES = %w[people opinions auto technologies realty]
Admin.create({ email: ENV['ADMIN_EMAIL'], password:  ENV['ADMIN_PASSWORD'], password_confirmation:  ENV['ADMIN_PASSWORD_CONFIRM'] })
CATEGORIES.each do |category|
  Category.find_or_create_by(name: category)
end
