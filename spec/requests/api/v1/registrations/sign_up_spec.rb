# frozen_string_literal: true

RSpec.describe 'POST /v1/sign_up', type: :request do
  before { post api_v1_sign_up_path, params: params }

  context 'with all params valid' do
    let(:params) { attributes_for(:user) }

    it 'returns status code :created' do
      expect(response).to have_http_status(:created)
    end

    it 'creates new user with requested attributes' do
      expect(User.count).to equal(1)
      user = User.last
      expect(user.username).to eq(params[:username])
      expect(user.email).to eq(params[:email])
    end

    it 'returns expected response body' do
      expect(response).to match_json_schema('auth/success/auth_tokens')
    end
  end

  context 'without :username' do
    let(:params) { attributes_for(:user).delete_if { |key, _| key == :username } }

    it 'returns response with :unprocessable_entity status code' do
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'returns expected errors' do
      expect(response).to match_json_schema('auth/failure/username_invalid')
    end
  end

  context 'without :email' do
    let(:params) { attributes_for(:user).delete_if { |key, _| key == :email } }

    it 'returns response with :unprocessable_entity status code' do
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'returns expected errors' do
      expect(response).to match_json_schema('auth/failure/email_invalid')
    end
  end

  context 'without :password' do
    let(:params) { attributes_for(:user).delete_if { |key, _| key == :password } }

    it 'returns response with :unprocessable_entity status code' do
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'returns expected errors' do
      expect(response).to match_json_schema('auth/failure/password_invalid')
    end
  end

  context 'without :password_confirmation' do
    let(:params) { attributes_for(:user).delete_if { |key, _| key == :password_confirmation } }

    it 'returns response with :unprocessable_entity status code' do
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'returns expected errors' do
      expect(response).to match_json_schema('auth/failure/password_confirmation_invalid')
    end
  end

  context 'with :password_confirmation not matching :password' do
    let(:params) do
      attributes_for(:user).merge(
        password: Faker::Internet.unique.password,
        password_confirmation: Faker::Internet.unique.password
      )
    end

    it 'returns response with :unprocessable_entity status code' do
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'returns expected errors' do
    end
  end

  context 'without all neccessary params' do
    let(:params) { {} }

    it 'returns response with :unprocessable_entity status code' do
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'returns expected errors' do
      expect(response).to match_json_schema('auth/failure/all_params_invalid')
    end
  end
end
