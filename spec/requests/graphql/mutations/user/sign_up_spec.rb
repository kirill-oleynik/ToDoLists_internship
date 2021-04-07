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

  context 'user already exists' do
    let!(:user) { create(:user) }
    let(:request_params) { attributes_for(:user).merge(username: user.username) }

    it 'returns expected response' do
      binding.pry
    end
  end
end
