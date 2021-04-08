# frozen_string_literal: true

RSpec.describe 'mutation userSignUp', type: :request do
  let(:request_params) { attributes_for(:user) }

  before do
    graphql_post(
      query: signup_mutation,
      variables: request_params
    )
  end

  context 'with all params valid' do
    let(:user) { User.last }

    it 'returns expected response' do
      expect(response).to match_json_schema('auth/success/sign_up')
    end

    it 'creates user with reuested attributes' do
      expect(User.count).to eq(1)
      expect(user.username).to eq(request_params[:username])
      expect(user.email).to eq(request_params[:email])
      expect(
        user.authenticate(request_params[:password])
      ).to equal(user)
    end
  end

  context 'with already existing :username' do
    let!(:user) { create(:user) }
    let(:request_params) { attributes_for(:user).merge(username: user.username) }

    it 'returns expected response' do
      expect(error_info).to include(':username')
      expect(response).to match_json_schema('auth/failure/sign_up')
      expect(graphql_response_error_status_code)
        .to eq(Constants::GraphQL::RESPONSE_STATUSES[:status422])
    end
  end

  context 'with confirmation not matching password' do
    let(:request_params) do
      attributes_for(:user).merge(
        password: Faker::Internet.unique.password,
        password_confirmation: Faker::Internet.unique.password
      )
    end

    it 'returns expected response' do
      expect(error_info).to include(':password_confirmation')
      expect(response).to match_json_schema('auth/failure/sign_up')
      expect(graphql_response_error_status_code)
        .to eq(Constants::GraphQL::RESPONSE_STATUSES[:status422])
    end
  end
end
