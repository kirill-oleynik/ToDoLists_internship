# frozen_string_literal: true

RSpec.describe 'DELETE /v1/tasks/:task_id/comments/:id', type: :request do
  before { delete api_v1_task_comment_path(task, comment), headers: headers, as: :json }

  let(:headers) { { 'Authorization': token } }
  let(:token) { JwtSession::Create.new.call(user_id: task.user.id).login[:access] }
  let(:task) { create_task_with_comment }
  let(:comment) { task.comments.first }

  context 'with all headers & params valid' do
    it 'returns response with status code 200' do
      expect(response).to have_http_status(:ok)
    end

    it 'returns deleted comment' do
      expect(response).to match_json_schema('entities/comment')
    end
  end

  context 'when task doest not belong to user' do
    let(:token) { JwtSession::Create.new.call(user_id: create(:user).id).login[:access] }

    it 'returns response with status code 404' do
      expect(response).to have_http_status(:not_found)
    end
  end

  context 'when comment does not belong to task' do
    let(:comment) { create(:comment) }

    it 'returns response with status code 404' do
      expect(response).to have_http_status(:not_found)
    end
  end
end
