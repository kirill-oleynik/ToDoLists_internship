# frozen_string_literal: true

RSpec.describe API::V1::Auth::Contract::RefreshToken, type: :contract do
  subject(:contract) { described_class.new.call(params) }

  context 'with all params valid called' do
    let(:params) { { refresh_token: 'refresh_token' } }

    it { is_expected.to be_success }
  end

  context 'without :refresh_token called' do
    let(:params) { { success_token: 'refresh_token' } }

    it { is_expected.to be_failure }

    it 'returns expected errors' do
      expect(contract.errors.to_hash[:refresh_token]).to include('is missing')
    end
  end

  context 'with invalid :refresh_token type called' do
    let(:params) { { success_token: 0 } }

    it { is_expected.to be_failure }

    it 'returns expected errors' do
      expect(contract.errors.to_hash[:refresh_token]).to include('is missing')
    end
  end
end
