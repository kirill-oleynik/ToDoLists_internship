# frozen_string_literal: true

RSpec.describe API::V1::Auth::Contract::SignIn, type: :contract do
  subject(:contract) { described_class.new(dummy_model) }

  let(:dummy_model) { build(:user) }

  before { contract.validate(params: params) }

  context 'tith all params valid' do
    let(:params) { attributes_for(:user).slice(:username, :password) }

    it 'succeeds' do
      binding.pry
      # expect(contract.success?).to equeal(true)
    end
  end
end
