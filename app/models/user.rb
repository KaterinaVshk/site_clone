class User < ApplicationRecord
  VALID_EMAIL = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/.freeze
  has_secure_password
  validates :email,
            uniqueness: { message: 'Такой пользователь уже зарегистрирован' },
            presence: { message: 'Укажите email' },
            format: { with: VALID_EMAIL, message: ' Некорректный email ' }
  validates :password,
            length: { minimum: 8, maxmimum: 64, message: 'Пароль должен быть от 8 до 64 символов' },
            presence: { message: 'Пароль обязательный' }
end
