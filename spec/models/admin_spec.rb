require 'rails_helper'

RSpec.describe(Admin, type: :model) do
  let(:admin1) { create(:admin) }

  describe 'when admin is created' do
    it 'confirms validation' do
      expect(admin1).to(be_valid)
    end
  end
end
