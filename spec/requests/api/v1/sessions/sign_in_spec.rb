# frozen_string_literal: true

RSpec.describe 'POST /v1/acconts/sessions', type: :request do
  before { post(api_v1_accounts_session_path, params: params) }

  context 'with all prams valid valled' do
    let(:params) { create(:user).slice(:username, :password) }

    it 'returns :created status code' do
      expect(response).to have_http_status(:created)
    end
  end
end
