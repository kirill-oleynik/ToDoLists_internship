# frozen_string_literal: true

RSpec.describe API::V1::Tasks::Contract::Show, type: :contract do
  subject(:contract) { described_class.new.call(params) }

  context 'with all params valid called' do
    let(:params) { { id: create(:task).id } }

    it { is_expected.to be_success }
  end

  context 'without :id called' do
    let(:params) { {} }

    it { is_expected.to be_failure }

    it 'returns expected error message' do
      expect(contract.errors.to_h[:id]).to include('is missing')
    end
  end

  context 'with invalid :id data type called' do
    let(:params) { { d: 123 } }

    it { is_expected.to be_failure }

    it 'returns expected error message' do
      expect(contract.errors.to_h[:id]).to include('is missing')
    end
  end
end
