# frozen_string_literal: true

RSpec.describe 'Users', type: :request do
  describe '[POST] /v1/users' do
    before { post(api_v1_users_path, { params: user_params }) }

    context 'with all params valid' do
      let(:user_params) { { user: attributes_for(:user) } }

      it 'creates new user' do
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid params' do
      describe ':username missing' do
        let(:user_params) { { user: attributes_for(:user).reject { |k| k == :username } } }

        it 'returns expected error' do
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end
  end
end
