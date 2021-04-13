require 'rails_helper'

RSpec.describe(Article, type: :model) do
  describe 'validations' do
    describe '#title' do
      it { is_expected.to(validate_presence_of(:title)) }
    end

    describe '#image' do
      subject { create(:article).image }

      it { is_expected.to(be_an_instance_of(ActiveStorage::Attached::One)) }
    end
  end

  describe 'associations' do
    it { is_expected.to(belong_to(:category)) }
  end
end
