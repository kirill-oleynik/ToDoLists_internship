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
      # binding.pry
      # parsed_body['errors']
      #      [{"message"=>"Field 'SignUp' doesn't exist on type 'Mutation'",
      #  "locations"=>[{"line"=>3, "column"=>11}],
      #  "path"=>["mutation SignUp", "SignUp"],
      #  "extensions"=>{"code"=>"undefinedField", "typeName"=>"Mutation", "fieldName"=>"SignUp"}},
      # {"message"=>"Variable $input is declared by SignUp but not used",
      #  "locations"=>[{"line"=>2, "column"=>9}],
      #  "path"=>["mutation SignUp"],
      #  "extensions"=>{"code"=>"variableNotUsed", "variableName"=>"input"}}]
    end
  end
end
