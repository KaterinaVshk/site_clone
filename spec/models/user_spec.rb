require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#email' do
    it { is_expected.to(validate_presence_of(:email)) }
  end

  describe '#password' do
    it { is_expected.to(validate_length_of(:password).is_at_least(8)) }
  end
end
