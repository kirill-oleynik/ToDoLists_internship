# frozen_string_literal: true

RSpec.describe 'PUT    /v1/tasks/:task_id/comments/:id', type: :request do
  before { put api_v1_task_comment_path(task, comment), headers: headers, params: params, as: :json }

  let(:headers) { { 'Authorization': token } }
  let(:token) { JwtSession::Create.new.call(user_id: task.user.id).login[:access] }
  let(:task) { create_task_with_comments(comments_count: 1) }
  let(:comment) { task.comments.first }
  let(:params) do
    {
      comment: { title: 'title' }
    }
  end

  context 'with all params & headers requested' do
    it 'returns response with status code 200' do
      expect(response).to have_http_status(:ok)
    end

    it 'returns updated comment' do
      expect(response).to match_json_schema('entities/comment')
      expect(parsed_body['data']['id']).to eq(comment.id)
      expect(parsed_body['data']['attributes']['title']).to eq('title')
    end
  end

  context 'when task does not belongs to user' do
    let(:token) { JwtSession::Create.new.call(user_id: create(:user).id).login[:access] }

    it 'returns response with status code 404' do
      expect(response).to have_http_status(:not_found)
    end
  end

  context 'when comment does not belongs to task' do
    let(:comment) { create(:comment) }

    it 'returns response with status code 404' do
      expect(response).to have_http_status(:not_found)
    end
  end

  context 'when comment has valid attached image (file upload)' do
    let(:comment) { create(:comment, :with_valid_attachment, task: task) }

    it 'returns response with status code 200' do
      expect(response).to have_http_status(:ok)
    end

    it 'returns serialized comment' do
      expect(response).to match_json_schema('entities/comment')
    end
  end
end
