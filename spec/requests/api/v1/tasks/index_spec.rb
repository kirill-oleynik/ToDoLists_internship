# frozen_string_literal: true

RSpec.describe 'GET /v1/tasks/', type: :request do
  before { get api_v1_tasks_path, headers: headers, as: :json }

  let(:headers) { { 'Authorization': access_token } }
  let(:access_token) { JwtSession::Create.new.call(user_id: user.id).login[:access] }

  context 'with all params & header valid requested' do
    let(:user) { create_user_with_tasks(tasks_count: 10) }

    it 'returns response with status 200' do
      expect(response).to have_http_status(:ok)
    end

    it 'returns user\'s tasks' do
      expect(response).to match_json_schema('entities/tasks')
    end
  end

  context 'when user has no tasks' do
    let(:user) { create(:user) }

    it 'returns response with status 200' do
      expect(response).to have_http_status(:ok)
    end

    it 'returns empty collection' do
      expect(parsed_body).to be_empty
    end
  end
end
