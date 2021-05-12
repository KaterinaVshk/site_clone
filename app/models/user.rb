class User < ApplicationRecord
  VALID_EMAIL = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/.freeze
  PER_PAGE = 10
  has_secure_password
  validates :email,
            uniqueness: { message: 'Такой пользователь уже зарегистрирован' },
            presence: { message: 'Укажите email' },
            format: { with: VALID_EMAIL, message: ' Некорректный email ' }
  validates :password,
            length: { minimum: 8, maxmimum: 64, message: 'Пароль должен быть от 8 до 64 символов' },
            presence: { message: 'Пароль обязательный' },
            on: :create
  validates :nickname,
            uniqueness: { message: 'Такой ник уже занят' },
            length: { maximum: 25, message: 'Ник может содержать до 25 символов' },
            allow_blank: true
  validates :first_name, length: { maximum: 50, message: 'Имя может содержать до 50 символов' }
  validates :last_name, length: { maximum: 50, message: 'Фамилия может содержать до 50 символов' }
  validates :birthday,
            date: {
              after: proc { Time.zone.now - 125.years },
              before: proc { Time.zone.now - 18.years },
              message: 'Возраст может быть от 18 до 125'
            },
            allow_blank: true
  validates :city, length: { maximum: 40, message: 'Название города может содержать до 40 символов' }
  has_one_attached :photo
end
