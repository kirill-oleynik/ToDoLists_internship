# frozen_string_literal: true

RSpec.describe 'DELETE /v1/accounts/session', type: :request do
  before { delete api_v1_accounts_session_path, headers: headers, as: :json }

  let(:headers) { { 'X-Refresh-Token': refresh_token } }

  context 'with valid refresh_token requested' do
    let(:refresh_token) { new_user_auth_tokens[:refresh] }

    it 'returns 200 status code' do
      expect(response).to have_http_status(:ok)
    end

    it 'returs nullified response body' do
      expect(parsed_body).to be_nil
    end
  end

  context 'with invalid refresh token requested' do
    let(:refresh_token) { Faker::Lorem.sentence }

    it 'returns 401 status code' do
      expect(response).to have_http_status(:unauthorized)
    end

    it 'returns Not authorized message as response body' do
      expect(parsed_body['error']).to eq('Not authorized')
    end
  end

  context 'without refresh_token requested' do
    let(:refresh_token) { nil }

    it 'returns 401 status code' do
      expect(response).to have_http_status(:unauthorized)
    end

    it 'returns Not authorized message as response body' do
      expect(parsed_body['error']).to eq('Not authorized')
    end
  end
end
