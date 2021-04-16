# frozen_string_literal: true

RSpec.describe API::V1::Auth::Operation::SignIn, type: :operation do
  subject(:result) { described_class.call(params: params) }

  context 'with all params valid called' do
    let(:params) { create(:user).slice(:username, :password) }

    it { is_expected.to be_success }

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

  context 'without :username called' do
    let(:params) { create(:user).slice(:password) }

    it { is_expected.to be_failure }

    it 'returns nullified result' do
      expect(result[:result]).to be_nil
    end
  end

  context 'without :password called' do
    let(:params) { create(:user).slice(:username) }

    it { is_expected.to be_failure }

    it 'returns nullified result' do
      expect(result[:result]).to be_nil
    end
  end

  context 'with all params invalid valled called' do
    let(:params) { { username: 0, password: 0 } }

    it { is_expected.to be_failure }

    it 'returns nullified result' do
      expect(result[:result]).to be_nil
    end
  end

  context 'with empty params called' do
    let(:params) { {} }

    it { is_expected.to be_failure }

    it 'returns nullified result' do
      expect(result[:result]).to be_nil
    end
  end

  context 'with unexisting :susername & random :password called' do
    let(:params) do
      {
        username: Faker::Internet.username,
        password: Faker::Internet.password
      }
    end

    it 'returns nullidied result' do
      expect(result[:result]).to be_nil
    end

    it 'returns expected :operation status' do
      expect(result[:operation_status]).to eq(:unauthorized)
    end

    it 'reutns expected error' do
      expect(result[:error]).to eq(ActiveRecord::RecordNotFound)
    end
  end
end
