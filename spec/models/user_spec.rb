# frozen_string_literal: true

RSpec.describe User, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:tasks) }

    it 'destroys dependent tasks after deletion' do
      expect(Task.count).to equal(0)
      user = create_user_with_tasks(tasks_count: 10)
      expect(Task.count).to equal(10)
      user.destroy
      expect(Task.count).to equal(0)
    end
  end
end
