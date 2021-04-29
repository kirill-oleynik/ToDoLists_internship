# frozen_string_literal: true

RSpec.describe API::V1::Tasks::Contract::Create, type: :contract do
  subject(:contract) { described_class.new.call(params) }

  context 'with all params valid called' do
    let(:params) { attributes_for(:task) }

    it { is_expected.to be_success }
  end

  context 'without :title called' do
    let(:params) { attributes_for(:task).delete_if { |k, _| k == :title } }

    it { is_expected.to be_success }
  end

  context 'without :done called' do
    let(:params) { attributes_for(:task).delete_if { |k, _| k == :done } }

    it { is_expected.to be_success }
  end

  context 'without :deadline called' do
    let(:params) { attributes_for(:task).delete_if { |k, _| k == :deadline } }

    it { is_expected.to be_success }
  end

  context 'with invalid :title data type called' do
    let(:params) { attributes_for(:task).merge(title: true) }

    it { is_expected.not_to be_success }

    it 'returns expected error' do
      expect(contract.errors.to_hash[:title]).to include('must be a string')
    end
  end

  context 'with invalid :done data type called' do
    let(:params) { attributes_for(:task).merge(done: 'true') }

    it { is_expected.not_to be_success }

    it 'returns expected error' do
      expect(contract.errors.to_hash[:done]).to include('must be boolean')
    end
  end

  context 'with invalid :deadline data type called' do
    let(:params) { attributes_for(:task).merge(deadline: 123) }

    it { is_expected.not_to be_success }

    it 'returns expected error' do
      expect(contract.errors.to_hash[:deadline]).to include('must be a string')
    end
  end

  context 'with past :deadline called' do
    let(:params) { attributes_for(:task).merge(deadline: (Date.today - 1).to_s) }

    it { is_expected.not_to be_success }

    it 'returns expeected error message' do
      expect(contract.errors.to_hash[:deadline]).to include('must be in the future')
    end
  end

  context 'without all the arguments called' do
    let(:params) { {} }

    it { is_expected.to be_success }
  end
end
