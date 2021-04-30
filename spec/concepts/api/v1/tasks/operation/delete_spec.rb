# frozen_string_literal: true

RSpec.describe API::V1::Tasks::Operation::Delete, type: :operation do
  subject(:result) { described_class.call(token: token, params: params) }

  let(:token) { JwtSession::Create.new.call(user_id: user.id).login[:access] }

  let(:user) { create_user_with_tasks(tasks_count: 1) }
  let(:task) { user.tasks.first }

  before { result }

  context 'with all params valid valled' do
    let(:params) { { id: task.id } }

    it { is_expected.to be_success }

    it 'returns deleted task' do
      expect(result['model']).to eq(task)
    end

    it 'deletes task entity' do
      expect(user.tasks.count).to equal(0)
    end
  end

  context 'without :token called' do
    let(:params) { { id: task.id } }
    let(:token) { nil }

    it { is_expected.to be_failure }

    it 'returns operation_status: :unauthorized' do
      expect(result['operation_status']).to eq(:unauthorized)
    end

    context 'when contract validation fails' do
      let(:params) { {} }

      it { is_expected.to be_failure }

      it 'returns expected error messages' do
        expect(result['contract.default'].errors.to_h[:id]).to include('is missing')
      end
    end

    context 'when unexisting task requested' do
      let(:params) { { id: SecureRandom.uuid } }
      let(:token) { JwtSession::Create.new.call(user_id: task.user_id).login[:access] }

      it { is_expected.to be_failure }

      it 'returns operation_status: :not_found' do
        expect(result['operation_status']).to eq(:not_found)
      end
    end
  end

  context 'with invalid task id called' do
    let(:task) { create(:task) }
    let(:params) { { id: task.id } }

    it { is_expected.to be_failure }

    it 'does not deletes user tasks' do
      expect(user.tasks.count).to equal(1)
    end

    it 'returns :operation_status :not_found' do
      expect(result[:operation_status]).to eq(:not_found)
    end
  end
end
