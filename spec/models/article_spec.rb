require 'rails_helper'

RSpec.describe(Article, type: :model) do
  describe 'validations' do
    describe '#title' do
      it { is_expected.to(validate_presence_of(:title).with_message('Укажите название')) }
    end

    describe '#text' do
      it { is_expected.to(validate_presence_of(:text).with_message('Напишите текст')) }
    end

    describe '#image' do
      subject { create(:article).image }

      it { is_expected.to(be_an_instance_of(ActiveStorage::Attached::One)) }
    end
  end

  describe 'associations' do
    it { is_expected.to(belong_to(:category)) }
    it { is_expected.to(belong_to(:admin)) }
  end
end
