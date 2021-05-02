# frozen_string_literal: true

RSpec.describe Comment, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:task) }
  end
end
