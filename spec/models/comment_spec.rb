# frozen_string_literal: true

RSpec.describe Comment, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:task) }
    it { is_expected.to have_db_column(:image_data) }
  end
end
