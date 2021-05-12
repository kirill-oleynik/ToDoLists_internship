# frozen_string_literal: true

RSpec.describe 'POST /v1/tasks', type: :request do
  before { post api_v1_tasks_path, headers: headers, params: params, as: :json }

  let(:headers) { { 'Authorization': access_token } }

  context 'with valid params & headers requested' do
    let(:access_token) { new_user_auth_tokens[:access] }
    let(:params) { attributes_for(:task) }

    it 'returns request status 201' do
      expect(response).to have_http_status(:created)
    end

    it 'returns entire info about created entity' do
      expect(response).to match_json_schema('entities/task')
    end
  end

  context 'without headers requested' do
    let(:params) { attributes_for(:task) }
    let(:headers) { nil }

    it 'returns response with 401 status code' do
      expect(response).to have_http_status(:unauthorized)
    end
  end

  context 'with invalid token requested' do
    let(:headers) { { 'Authorization': 'invalid_token' } }
    let(:params) { attributes_for(:task) }

    it 'returns response with 401 status code' do
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
