# frozen_string_literal: true

RSpec.describe 'PUT /v1/task/:id', type: :request do
  before do
    put api_v1_task_path(task.id), headers: headers, params: { task: task_attributes }, as: :json
  end

  let(:headers) { { 'Authorization': token } }

  let(:token) { JwtSession::Create.new.call(user_id: task.user.id).login[:access] }
  let(:task) { create(:task) }
  let(:task_attributes) { { 'title': 'title', deadline: Date.tomorrow.to_s } }

  context 'with all params & header valid requested' do
    it 'returns response with status code 200' do
      expect(response).to have_http_status(:ok)
    end

    it 'returns updated task in response body' do
      expect(response).to match_json_schema('entities/task')
    end
  end

  context 'when task does not belongs to user' do
    let(:token) { JwtSession::Create.new.call(user_id: create(:user).id).login[:access] }

    it 'returns response with status code 404' do
      expect(response).to have_http_status(:not_found)
    end
  end

  context 'with invalid token requested' do
    let(:token) { SecureRandom.uuid }

    it 'returns response with status code 401' do
      expect(response).to have_http_status(:unauthorized)
    end
  end

  context 'with invalid task attributes requested' do
    let(:task_attributes) { { 'title': 123, deadline: Date.tomorrow.to_s } }

    it 'returns response with status code 422' do
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
