# frozen_string_literal: true

RSpec.describe API::V1::Comments::Operation::Delete, type: :operation do
  subject(:result) { described_class.call(token: token, params: params) }

  before { result }

  let(:token) { new_user_auth_tokens(user: task.user)[:access] }

  let(:task) { create_task_with_comment }
  let(:comment) { task.comments.first }
  let(:params) { { task_id: task.id, id: comment.id } }
  # let(:params) do
  #   {
  #     task_id: task.id,
  #     id: comment.id
  #   }
  # end

  context 'with all params valid called' do
    it { is_expected.to be_success }

    it 'deletes expected comment' do
      expect(Comment.exists?(comment.id)).to equal(false)
    end
  end

  context 'when task does not belongs to user' do
    let(:token) { new_user_auth_tokens(user: create(:user))[:access] }

    it { is_expected.to be_failure }

    it 'returns :operation _status :not_found' do
      expect(result[:operation_status]).to eq(:not_found)
    end
  end

  context 'when comment does not belong to ttask' do
    let(:comment) { create(:comment) }

    it { is_expected.to be_failure }

    it 'returns :operation _status :not_found' do
      expect(result[:operation_status]).to eq(:not_found)
    end
  end
end
