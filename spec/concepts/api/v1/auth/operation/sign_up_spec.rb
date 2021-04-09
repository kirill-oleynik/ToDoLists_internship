# frozen_string_literal: true

RSpec.describe API::V1::Auth::Operation::SignUp, type: :operation do
  subject(:result) { described_class.call(params: params) }

  context 'with all params valid' do
    let(:params)  { attributes_for(:user) }

    it 'succeeds' do
      expect(result.success?).to equal(true)
      expect(User.count).to eq(1)
    end

    it 'includes :csrf at result' do
      expect(result[:result]).to have_key(:csrf)
      expect(result[:result][:csrf]).to be_a(String)
    end

    it 'includes :access token at result' do
      expect(result[:result]).to have_key(:access)
      expect(result[:result][:access]).to be_a(String)
    end

    it 'includes info about refresh token expiration time' do
      expect(result[:result]).to have_key(:refresh_expires_at)
    end

    it 'includes info about access token expiration time' do
      expect(result[:result]).to have_key(:access_expires_at)
    end

    it 'includes :refresh token at result' do
      expect(result[:result]).to have_key(:refresh)
      expect(result[:result][:refresh]).to be_a(String)
    end
  end

  context 'when params are invalid' do
    describe 'username is missing' do
      let(:params) { attributes_for(:user).slice(:email, :password, :password_confirmation) }

      it 'does not succeed' do
        expect(result.failure?).to equal(true)
      end

      it 'has nullified result' do
        expect(result[:result]).to be_nil
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

      it 'has nullified result' do
        expect(result[:result]).to be_nil
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

      it 'has nullified result' do
        expect(result[:result]).to be_nil
      end
    end

    describe 'password_confirmation does not matcth password' do
      let(:params) { attributes_for(:user).merge(password_confirmation: Faker::Internet.password) }

      it 'does not succeed' do
        expect(result.failure?).to equal(true)
      end

      it 'has nullified result' do
        expect(result[:result]).to be_nil
      end
    end
  end
end
