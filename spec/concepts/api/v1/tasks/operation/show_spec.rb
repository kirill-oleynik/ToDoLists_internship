# frozen_string_literal: true

RSpec.describe API::V1::Tasks::Operation::Show, type: :operation do
  subject(:result) { described_class.call(token: token, params: params) }

  let(:task) { create(:task) }

  before { result }

  context 'with all params valid valled' do
    let(:params) { { id: task.id } }
    let(:token) { JwtSession::Create.new.call(user_id: task.user_id).login[:access] }

    it { is_expected.to be_success }
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
end
