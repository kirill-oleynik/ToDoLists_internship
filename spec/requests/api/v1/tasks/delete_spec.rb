# frozen_string_literal: true

RSpec.describe 'DELETE /v1/tasks/:id', type: :request do
  before { delete api_v1_task_path(task_id), headers: headers, as: :json }

  let(:headers) { { 'Authorization': token } }

  let(:token) { JwtSession::Create.new.call(user_id: user_id).login[:access] }

  let(:task) { create(:task) }

  context 'with all params & header valid requested' do
    let(:task_id) { task.id }
    let(:user_id) { task.user_id }

    it 'returns response with status code 200' do
      expect(response).to have_http_status(:ok)
    end

    it 'deletes requested task' do
      expect(Task.exists?(task_id)).to equal(false)
    end

    it 'returns deleted task' do
      expect(response).to match_json_schema('entities/task')
      expect(parsed_body['data']['id']).to eq(task_id)
    end
  end

  context 'with invalid task id requested' do
    let(:task_id) { SecureRandom.uuid }
    let(:user_id) { task.user_id }

    it 'returns response with status code 404' do
      expect(response).to have_http_status(:not_found)
    end
  end

  context 'when user is trying to elete someone elses task' do
    let(:task_id) { task.id }
    let(:user_id) { create(:user).id }

    it 'returns response with status code 404' do
      expect(response).to have_http_status(:not_found)
    end
  end
end
