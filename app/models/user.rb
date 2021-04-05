class User < ApplicationRecord
    has_secure_password
    validates :email, uniqueness:  {message: "Такой пользователь уже зарегистрирован"}  , presence: {message: "Укажите email"}
    validates :password, length: { minimum: 8, maxmimum: 64,  message: "Пароль должен быть от 8 до 64 символов"},  presence: {message: "Пароль обязательный"}
end
