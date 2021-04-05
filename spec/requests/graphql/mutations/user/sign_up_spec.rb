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
    it 'returns auth tokens' do
      expect(User.count).to eq(1)
      expect(parsed_body['data']['signUp']['access']).to be_present
    end
  end
end
