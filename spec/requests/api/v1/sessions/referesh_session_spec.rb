# frozen_string_literal: true

RSpec.describe 'PUT /v1/accounts/session', type: :request do
  before { put(api_v1_accounts_session_path, params: params) }

  context 'with all params valid requested' do
    let(:params) { { refresh_token: new_user_auth_tokens[:refresh] } }

    it 'returns 200 status code' do
      expect(response).to have_http_status(:created)
    end

    it 'has no any response body' do
      expect(parsed_body).to be_nil
    end
  end

  context 'with invalid refresh token requested' do
    let(:params) { { refresh_token: Faker::Lorem.sentence } }

    it 'returns 422 status code' do
      expect(response).to have_http_status(:forbidden)
    end

    it 'has no any response body' do
      expect(response.body).to be_empty
    end
  end

  context 'without refresh_token requested' do
    let(:params) { { foo: 'bar' } }

    it 'returns 422 status code' do
      expect(response).to have_http_status(:forbidden)
    end

    it 'has no any response body' do
      expect(response.body).to be_empty
    end
  end
end
