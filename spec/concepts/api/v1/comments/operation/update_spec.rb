# frozen_string_literal: true

RSpec.describe API::V1::Comments::Operation::Update, type: :operation do
  subject(:result) { described_class.call(token: token, params: params) }

  let(:token) { new_user_auth_tokens(user: task.user)[:access] }

  let(:task) { create_task_with_comments(comments_count: 1) }
  let(:comment) { task.comments.first }

  let(:params) do
    {
      id: comment.id,
      task_id: task.id,
      comment: { title: 'title' }
    }
  end

  context 'with all params valid called' do
    it { is_expected.to be_success }

    it 'returns updated comment' do
      expect(result[:model]).to eq(comment)
      expect(result[:model][:title]).to eq('title')
    end
  end

  context 'with invalid token called' do
    let(:token) { SecureRandom.uuid }

    it { is_expected.to be_failure }

    it 'returns :operation_status :unauthorized' do
      expect(result[:operation_status]).to eq(:unauthorized)
    end
  end

  context 'when task does not belong to user' do
    let(:token) { new_user_auth_tokens(user: create(:user))[:access] }

    it 'returns :operation_status :not_found' do
      expect(result[:operation_status]).to eq(:not_found)
    end
  end

  context 'when comment does not belong to task' do
    let(:comment) { create(:comment) }

    it 'returns :operation_status :not_found' do
      expect(result[:operation_status]).to eq(:not_found)
    end
  end
end
