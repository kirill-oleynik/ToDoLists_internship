# frozen_string_literal: true

RSpec.describe API::V1::Auth::Contract::SignIn, type: :contract do
  subject(:contract) { described_class.new.call(params) }

  context 'with all params valid called' do
    let(:params) { attributes_for(:user).slice(:username, :password) }

    it { is_expected.to be_success }
  end

  context 'without :username called' do
    let(:params) { attributes_for(:user).slice(:password) }

    it { is_expected.to be_failure }

    it 'returns expected error message' do
      expect(contract.errors[:username]).to include('is missing')
    end
  end

  context 'with invalid :username type called' do
    let(:params) { attributes_for(:user).slice(:password).merge(username: 1) }

    it { is_expected.to be_failure }

    it 'returns expected error message' do
      expect(contract.errors[:username]).to include('must be a string')
    end
  end

  context 'without :password' do
    let(:params) { attributes_for(:user).slice(:username) }

    it { is_expected.to be_failure }

    it 'returns expected error message' do
      expect(contract.errors[:password]).to include('is missing')
    end
  end

  context 'with invalid :password type called' do
    let(:params) { attributes_for(:user).slice(:username).merge(password: 1) }

    it { is_expected.to be_failure }

    it 'returns expected error message' do
      expect(contract.errors[:password]).to include('must be a string')
    end
  end

  context 'with all invalid params called' do
    let(:params) { { username: 1, password: 1 } }

    it { is_expected.to be_failure }
  end

  context 'with all empty params called' do
    let(:params) { {} }

    it { is_expected.to be_failure }

    it 'returns expected error messages' do
      expect(contract.errors[:password]).to include('is missing')
      expect(contract.errors[:username]).to include('is missing')
    end
  end
end
