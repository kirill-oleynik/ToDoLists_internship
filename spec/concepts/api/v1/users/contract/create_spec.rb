# frozen_string_literal: true

RSpec.describe API::V1::Users::Contract::Create, type: :contract do
  subject(:contract) { described_class.new(user) }

  let(:user) { build(:user) }

  before { contract.validate(params) }

  context 'when all params are valid' do
    let(:params) { attributes_for(:user) }

    it 'succeeds' do
      expect(contract.errors.empty?).to equal(true)
    end
  end

  context 'when one attribute missing' do
    describe ':username' do
      let(:params) { attributes_for(:user).merge(username: '') }

      it 'returns expected error' do
        expect(contract.errors.size).to eq(1)
        expect(contract.errors[:username]).to include('must be filled')
      end
    end

    describe ':email' do
      let(:params) { attributes_for(:user).merge(email: '') }

      it 'returns expected error' do
        expect(contract.errors.size).to eq(1)
        expect(contract.errors[:email]).to include('must be filled')
      end
    end
  end
  context 'when one attribute is invalid' do
    describe ':username' do
    end
describe ':email' do
  let(:params) { attributes_for(:user).merge( username: 0 ) }
  it 'returns expected error' do
        expect(contract.errors.size).to eq(1)
        expect(contract.errors[:username]).to include('must be a string')
  end
end
describe ':email format' do
  let(:params) { attributes_for(:user).merge( email: 'email' ) }
  it 'returns expeted error' do
        expect(contract.errors.size).to eq(1)
        expect(contract.errors[:email]).to include('is in invalid format')
  end
  describe ':email data type' do
  let(:params) { attributes_for(:user).merge( email: 0 ) }
  it 'returns expected error' do
        expect(contract.errors.size).to eq(1)
        expect(contract.errors[:email]).to include('must be a string')
  end
  end
end
  end
  context 'when all attributes are invalid' do
    let(:params) { { username: 0, email: 'email' } }
    it 'returns expected errors' do
        expect(contract.errors.size).to eq(2)
        expect(contract.errors[:email]).to include('is in invalid format')
        expect(contract.errors[:username]).to include('must be a string')
    end
  end
end
