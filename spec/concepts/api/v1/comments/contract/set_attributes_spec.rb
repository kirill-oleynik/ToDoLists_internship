# frozen_string_literal: true

RSpec.describe API::V1::Comments::Contract::SetAttributes, type: :contract do
  subject(:contract) { described_class.new.call(params) }

  context 'with all params valid called' do
    let(:params) { attributes_for(:comment) }

    it { is_expected.to be_success }
  end

  context 'without :title attribute called' do
    let(:params) { attributes_for(:comment).delete_if { |k, _| k == :title } }

    it { is_expected.to be_failure }

    it 'returns expected error messages' do
      expect(contract.errors[:title]).to include('is missing')
    end
  end

  context 'when :title attribute has invalid data type' do
    let(:params) { attributes_for(:comment).merge(title: 0) }

    it { is_expected.to be_failure }

    it 'returns expected error messages' do
      expect(contract.errors[:title]).to include('must be a string')
    end
  end

  context 'when comment params includes valid file upload' do
    let(:params) { attributes_for(:comment, :with_valid_attachment) }

    it { is_expected.to be_success }
  end

  context 'when comment params includes invalid file upload' do
    let(:params) { attributes_for(:comment, :with_invalid_attachment) }

    it { is_expected.to be_failure }

    it 'returns error message about file type' do
      expect(contract.errors[:image]).to include('type must be one of: image/jpeg, image/png')
    end

    it 'returns error message about file extendion' do
      expect(contract.errors[:image]).to include('extension must be one of: jpg, jpeg, png')
    end
  end
end
