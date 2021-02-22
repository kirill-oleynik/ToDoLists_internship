# frozen_string_literal: true

RSpec.describe API::V1::Users::Operation::Create, type: :operation do
  subject(:result) { described_class.call(params: params) }

  context 'when all params are valid' do
    let(:params)  { attributes_for(:user) }

    it 'succeeds' do
      expect(result.success?).to equal(true)
      expect(User.count).to eq(1)
    end
  end

  context 'when params are invalid' do
    describe 'username is missing' do
      let(:params) { attributes_for(:user).slice(:email, :password, :password_confirmation) }

      it 'does not succeed' do
        expect(result.failure?).to equal(true)
      end

      it 'provides expeccted errors' do
        expect(result['contract.default'].errors.messages[:username]).to include('must be filled')
      end
    end

    describe 'email is missing' do
      let(:params) { attributes_for(:user).slice(:username, :password, :password_confirmation) }

      it 'does not succeed' do
        expect(result.failure?).to equal(true)
      end

      it 'provides expeccted errors' do
        expect(result['contract.default'].errors.messages[:email]).to include('must be filled')
      end
    end

    describe 'password is missing' do
      let(:params) { attributes_for(:user).slice(:username, :email, :password_confirmation) }

      it 'does not succeed' do
        expect(result.failure?).to equal(true)
      end
    end

    describe 'password_confirmation does not matcth password' do
      let(:params) { attributes_for(:user).merge(password_confirmation: Faker::Internet.password) }

      it 'does not succeed' do
        expect(result.failure?).to equal(true)
      end
    end
  end
end
