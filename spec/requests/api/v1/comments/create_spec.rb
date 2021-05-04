# frozen_string_literal: true

RSpec.describe 'POST v1/comments', type: :request do
  before { post api_v1_task_comments_path(task_id: task.id), headers: headers, params: params, as: :json }

  let(:task) { create(:task) }

  let(:params) { { comment: attributes_for(:comment) } }

  let(:headers) { { 'Authorization': token } }

  let(:token) { JwtSession::Create.new.call(user_id: task.user.id).login[:access] }

  context 'with all headers and params requested' do
    it 'returns response with status code 201' do
      expect(response).to have_http_status(:created)
    end

    it 'returns serialized comment' do
      expect(response).to match_json_schema('entities/comment')
      expect(parsed_body['title']).to eq(params[:comment][:title])
      expect(parsed_body['task_id']).to eq(task.id)
    end
  end

  context 'with invalid token requested' do
    let(:token) { SecureRandom.uuid }

    it 'returns response with status code 401' do
      expect(response).to have_http_status(:unauthorized)
    end
  end

  context 'when user is not an owner of the task' do
    let(:token) { JwtSession::Create.new.call(user_id: create(:user).id).login[:access] }

    it 'returns response with status code 404' do
      expect(response).to have_http_status(:not_found)
    end
  end
end
