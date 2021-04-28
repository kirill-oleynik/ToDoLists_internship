# frozen_string_literal: true

RSpec.describe API::V1::Tasks::Operation::Create, type: :operation do
  subject(:result) { described_class.call(params: params) }

  context 'with all params valid called' do
    let(:params) { attributes_for(:task) }

    it { is_expected.to be_success }

    it 'returns created task as a model' do
      expect(result['model'].title).to eq(params[:title])
      expect(result['model'].user.id).to eq(params[:user_id])
    end
  end

  context 'with unexisting :user_id called' do
    let(:params) { attributes_for(:task).merge(user_id: SecureRandom.uuid) }

    it { is_expected.not_to be_success }

    it 'has operation_status: :unprocessable_entity' do
      expect(result[:operation_status]).to eq(:unprocessable_entity)
    end
  end
end
