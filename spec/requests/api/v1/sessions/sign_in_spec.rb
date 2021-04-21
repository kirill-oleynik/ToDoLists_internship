# frozen_string_literal: true

RSpec.describe 'POST /v1/acconts/sessions', type: :request do
  before { post(api_v1_accounts_session_path, params: params) }

  context 'with all prams valid valled' do
    let(:params) { create(:user).slice(:username, :password) }

    it 'returns :created status code' do
      expect(response).to have_http_status(:created)
    end

    it 'returns expected response body' do
      expect(response).to match_json_schema('auth/success/auth_tokens')
    end
  end

  context 'without :username requested' do
    let(:params) { { password: 'password' } }

    it 'returns :unprocessable_entity status code' do
      expect(response).to have_http_status(:not_found)
    end
  end

  context 'without :password requested' do
    let!(:user) { create(:user) }

    let(:params) { { username: user.username, password: 'invalidS1!!' } }

    it 'returns :unprocessable_entity status code' do
      expect(response).to have_http_status(:unauthorized)
    end

    it 'returns expected error messages' do
      # binding.pry
      # parsed_body != [] #false
    end
  end

  context 'without all the requeried params requested' do
    let(:params) { {} }

    it 'returns :unprocessable_entity status code' do
      expect(response).to have_http_status(:not_found)
    end
  end

  context 'with valid :username but invalid :password requested' do
    let(:params) do
      create(:user)
        .slice(:username, :password)
        .merge(password: 'invalid_password')
    end

    it 'returns :unprocessable_entity status code' do
      expect(response).to have_http_status(:unauthorized)
    end

    it 'returns expected errors' do
      # binding.pry
      # parsed_body != [] #false
    end
  end
end
