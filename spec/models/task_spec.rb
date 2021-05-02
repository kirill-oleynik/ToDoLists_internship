# frozen_string_literal: true

RSpec.describe Task, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:comments) }
  end

  it 'destroy dependent comments after deletion' do
    expect(Comment.count).to equal(0)
    task = create_task_with_comments(comments_count: 10)
    expect(Comment.count).to equal(10)
    task.destroy
    expect(Comment.count).to equal(0)
  end
end
