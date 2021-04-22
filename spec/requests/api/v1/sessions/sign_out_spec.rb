# frozen_string_literal: true

RSpec.describe 'DELETE /v1/accounts/session', type: :request do
  before { delete(api_v1_accounts_session_path, params: params) }

  context 'with all params valid requested' do
    let(:params) { { refresh_token: new_user_auth_tokens[:refresh] } }

    it 'returns 200 status code' do
      expect(response).to have_http_status(:ok)
    end

    it 'has no any response body' do
      expect(parsed_body).to be_nil
    end
  end

  context 'with invalid refresh token requested' do
    let(:params) { { refresh_token: Faker::Lorem.sentence } }

    it 'returns 422 status code' do
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'has no any response body' do
      expect(parsed_body).to be_empty
    end
  end

  context 'without refresh_token requested' do
    let(:params) { { foo: 'bar' } }

    it 'returns 422 status code' do
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'returns expected error messages' do
      expect(parsed_body[0]['path']).to include('refresh_token')
      expect(parsed_body[0]['text']).to include('is missing')
    end
  end
end
