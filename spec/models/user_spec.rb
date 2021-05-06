require 'rails_helper'

RSpec.describe(User, type: :model) do
  let(:user1) { create(:user) }

  describe 'validations' do
    describe '#email' do
      it 'when invalid email' do
        user1.email = 'jfbui'
        expect(user1).not_to(be_valid)
      end

      it { is_expected.to(validate_presence_of(:email).with_message('Укажите email')) }
      it { is_expected.to(validate_uniqueness_of(:email).with_message('Такой пользователь уже зарегистрирован')) }
      it { is_expected.to(allow_value('email@addresse.foo').for(:email)) }
      it { is_expected.not_to(allow_value('emaidregh').for(:email)) }
    end

    describe '#password' do
      it { is_expected.to(validate_presence_of(:password).with_message('Пароль обязательный')) }

      it {
        expect(subject).to(validate_length_of(:password).is_at_least(8).with_message('Пароль должен быть от 8 до 64 символов'))
      }
    end

    describe '#nickname' do
      it { is_expected.to(validate_uniqueness_of(:nickname).with_message('Такой ник уже занят')) }
      it { is_expected.to(validate_length_of(:nickname).is_at_most(25).with_message('Ник может содержать до 25 символов'))}
    end

    describe '#first_name' do
      it { is_expected.to(validate_length_of(:first_name).is_at_most(50).with_message('Имя может содержать до 50 символов'))}
    end

    describe '#last_name' do
      it { is_expected.to(validate_length_of(:last_name).is_at_most(50).with_message('Фамилия может содержать до 50 символов'))}
    end

    describe '#city' do
      it { is_expected.to(validate_length_of(:city).is_at_most(40).with_message('Название города может содержать до 40 символов'))}
    end
  end
end
