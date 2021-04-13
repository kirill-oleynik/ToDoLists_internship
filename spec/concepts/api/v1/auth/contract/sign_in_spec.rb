# frozen_string_literal: true

RSpec.describe API::V1::Auth::Contract::SignIn, type: :contract do
  subject(:contract) { described_class.new.call(params) }

  context 'with all params valid' do
    let(:params) { attributes_for(:user).slice(:username, :password) }

    it 'succeeds' do
      expect(contract).to be_success
    end
  end
end
