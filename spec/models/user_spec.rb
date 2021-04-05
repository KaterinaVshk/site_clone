require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'validations' do
    describe '#email' do
      it { is_expected.to(validate_presence_of(:email).with_message("Укажите email") ) }
      it { is_expected.to(validate_uniqueness_of(:email).with_message("Такой пользователь уже зарегистрирован") ) }
    end

    
    describe '#password' do
    it { is_expected.to(validate_presence_of(:password).with_message("Пароль обязательный")) }
      it { is_expected.to(validate_length_of(:password).is_at_least(8).with_message("Пароль должен быть от 8 до 64 символов")) }
    end
  end

end
