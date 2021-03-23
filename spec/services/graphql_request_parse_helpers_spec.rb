# frozen_string_literal: true

RSpec.describe GraphqlRequestParseHelpers do
  describe '#normalize_params' do
    subject(:normalized_params) do
      Object.new.extend(described_class).normalize_params(graphql_variables)
    end

    it 'has such method' do
      expect(Object.new.extend(described_class).respond_to?(:normalize_params)).to equal(true)
    end

    context 'with stringified json called' do
      let(:graphql_variables) do
        '{"username":"username",'\
        '"email":"email",'\
        '"password":"passwd",'\
        '"passwordConfirmation":"passwd"}'
      end

      it 'returns parsed hash' do
        expect(normalized_params).to be_a(Hash)
        expect(normalized_params['username']).to eq('username')
        expect(normalized_params['email']).to eq('email')
        expect(normalized_params['password']).to eq('passwd')
        expect(normalized_params['passwordConfirmation']).to eq('passwd')
      end
    end

    context 'with hash called' do
      let(:graphql_variables) do
        {
          username: 'username',
          email: 'email',
          password: 'passwd',
          passwordConfirmation: 'passwd'
        }
      end

      it 'returns same hash' do
        expect(normalized_params).to be_a(Hash)
        expect(normalized_params).to eq(graphql_variables)
        expect(normalized_params[:username]).to eq('username')
        expect(normalized_params[:email]).to eq('email')
        expect(normalized_params[:password]).to eq('passwd')
        expect(normalized_params[:passwordConfirmation]).to eq('passwd')
      end
    end

    context 'with ActionController::Parameters called' do
      let(:graphql_variables) do
        ActionController::Parameters.new(
          username: 'username',
          email: 'email',
          password: 'passwd',
          passwordConfirmation: 'passwd'
        )
      end

      it 'returns same object' do
        expect(normalized_params).to be_a(ActionController::Parameters)
        expect(normalized_params).to eq(graphql_variables)
        expect(normalized_params[:username]).to eq('username')
        expect(normalized_params[:email]).to eq('email')
        expect(normalized_params[:password]).to eq('passwd')
        expect(normalized_params[:passwordConfirmation]).to eq('passwd')
      end
    end

    context 'with Unexpected argument called' do
      let(:graphql_variables) { 0 }

      it 'raises Unexpected error' do
        expect { normalized_params }.to raise_error('Unexpected parameter: 0')
      end
    end
  end
end
