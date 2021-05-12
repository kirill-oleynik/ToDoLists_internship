# frozen_string_literal: true

RSpec.describe 'GET /v1/task/:id', type: :request do
  before { get api_v1_task_path(task_id), headers: headers, as: :json }

  let(:task) { create(:task) }

  let(:headers) { { 'Authorization': access_token } }

  context 'with all params & header valid requested' do
    let(:task_id) { task.id }
    let(:user_id) { task.user_id }
    let(:access_token) { JwtSession::Create.new.call(user_id: user_id).login[:access] }

    it 'returns response with 200 status code' do
      expect(response).to have_http_status(:ok)
    end

    it 'returns serialized task' do
      expect(response).to match_json_schema('entities/task')
    end

    it 'returns requested task' do
      expect(parsed_body['data']['id']).to eq(task_id)
      expect(parsed_body['data']['attributes']['user_id']).to eq(user_id)
    end
  end

  context 'with unexisting task id requested' do
    let(:task_id) { SecureRandom.uuid }
    let(:user_id) { task.user_id }
    let(:access_token) { JwtSession::Create.new.call(user_id: user_id).login[:access] }

    it 'returns response with 404 status code' do
      expect(response).to have_http_status(:not_found)
    end
  end
end
