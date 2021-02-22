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
    let(:params) { attributes_for(:user).merge(password: nil) }

    describe ':password' do
      it 'returns expected errors' do
        expect(contract.errors[:password]).to include('must be filled')
      end
    end

    describe ':username' do
      let(:params) { attributes_for(:user).merge(username: nil) }

      it 'returns expected error' do
        expect(contract.errors.size).to eq(1)
        expect(contract.errors[:username]).to include('must be filled')
      end
    end

    describe ':email' do
      let(:params) { attributes_for(:user).merge(email: nil) }

      it 'returns expected error' do
        expect(contract.errors.size).to eq(1)
        expect(contract.errors[:email]).to include('must be filled')
      end
    end

    describe ':password_confirmation' do
      let(:params) { attributes_for(:user).merge(password_confirmation: nil) }

      it 'returns expected errors' do
        expect(contract.errors.size).to eq(1)
        expect(contract.errors[:password_confirmation]).to include('must be filled')
      end
    end
  end

  context 'when one attribute is invalid' do
    describe ':username' do
      let(:params) { attributes_for(:user).merge(username: 0) }

      it 'returns expected error' do
        expect(contract.errors.size).to eq(1)
        expect(contract.errors[:username]).to include('must be a string')
      end
    end

    describe ':email format' do
      let(:params) { attributes_for(:user).merge(email: 'email') }

      it 'returns expeted error' do
        expect(contract.errors.size).to eq(1)
        expect(contract.errors[:email]).to include('is in invalid format')
      end

      describe ':email data type' do
        let(:params) { attributes_for(:user).merge(email: 0) }

        it 'returns expected error' do
          expect(contract.errors.size).to eq(1)
          expect(contract.errors[:email]).to include('must be a string')
        end
      end

      describe 'when passwordsize is less then required' do
        let(:params) { attributes_for(:user).merge(password: '123') }

        it 'returns expected errors' do
          expect(contract.errors[:password])
            .to include("size cannot be less than #{Constants::User::PASSWORD_MIN_SIZE}")
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
