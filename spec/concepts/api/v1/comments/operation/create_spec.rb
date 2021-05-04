# frozen_string_literal: true

RSpec.describe API::V1::Comments::Operation::Create, type: :operation do
  subject(:result) { described_class.call(token: token, params: params) }

  before { result }

  let(:token) { new_user_auth_tokens(user: task.user)[:access] }

  let(:task) { create(:task) }

  let(:params) do
    {
      task_id: task.id,
      comment: comment_params
    }
  end

  let(:comment_params) { attributes_for(:comment) }

  context 'with all params valid called' do
    it { is_expected.to be_success }

    it 'creates and returns new comment' do
      expect(Comment.count).to equal(1)
      expect(result['model']).to be_a(Comment)
    end

    it 'creates comment beloning to appropriate task' do
      expect(result['model'].task).to eq(task)
    end

    it 'creates comment with appropriate attributes' do
      expect(result['model'].title).to eq(comment_params[:title])
    end
  end

  context 'when task does not belongs to user' do
    let(:token) { new_user_auth_tokens(user: create(:user))[:access] }

    it { is_expected.to be_failure }

    it 'does not creates ne comment' do
      expect(Comment.count).to equal(0)
    end

    it 'returns :operation_status :not_found' do
      expect(result[:operation_status]).to eq(:not_found)
    end
  end

  context 'when comment contract fails' do
    let(:comment_params) { {} }

    it { is_expected.to be_failure }

    it 'does not creates ne comment' do
      expect(Comment.count).to equal(0)
    end

    it 'returns expected error messages' do
      expect(result['contract.default'].errors[:title]).to include('is missing')
    end
  end

  context 'with invalid token called' do
    let(:token) { SecureRandom.uuid }

    it {}
    it { is_expected.to be_failure }

    it 'returns :operation_status :unauthorized' do
      expect(result[:operation_status]).to eq(:unauthorized)
    end
  end
end
