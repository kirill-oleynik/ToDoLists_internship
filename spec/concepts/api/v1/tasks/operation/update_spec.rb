# frozen_string_literal: true

RSpec.describe API::V1::Tasks::Operation::Update, type: :operation do
  subject(:result) { described_class.call(token: token, params: params) }

  let(:token) { JwtSession::Create.new.call(user_id: user.id).login[:access] }

  let(:params) { { id: task.id, task: { title: 'title', deadline: Date.tomorrow.to_s } } }

  let(:user) { create_user_with_tasks(tasks_count: 1) }

  let(:task) { user.tasks.first }

  context 'with all params valid called' do
    it { is_expected.to be_success }

    it 'returns same updated task' do
      expect(result['model'].id).to eq(task.id)
      expect(result['model'].title).to eq('title')
      expect(result['model'].deadline).to eq(Date.tomorrow.to_s)
    end
  end

  context 'when user requested task does not belongs to user' do
    let(:task) { create(:task) }

    it { is_expected.to be_failure }

    it 'returns :operation_status :not_found' do
      expect(result[:operation_status]).to eq(:not_found)
    end
  end

  context 'with invalid token called' do
    let(:token) { SecureRandom.uuid }

    it { is_expected.to be_failure }

    it 'returns :operation_status :unauthorized' do
      expect(result[:operation_status]).to eq(:unauthorized)
    end
  end
end
