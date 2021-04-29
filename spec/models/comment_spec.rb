require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'validations' do
    describe '#title' do
      it { is_expected.to(validate_presence_of(:content)) }
    end
  end

  describe 'associations' do
    it { is_expected.to(belong_to(:commentable)) }
    it { is_expected.to(respond_to(:comments)) }
  end
end
