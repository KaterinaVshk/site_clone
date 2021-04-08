require 'rails_helper'

RSpec.describe(Category, type: :model) do
  describe 'validations' do
    describe '#name' do
      it { is_expected.to(validate_presence_of(:name)) }
      it { is_expected.to(validate_uniqueness_of(:name)) }
    end
  end
end
