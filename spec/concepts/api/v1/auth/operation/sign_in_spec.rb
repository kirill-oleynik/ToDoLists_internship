# frozen_string_literal: true

RSpec.describe API::V1::Auth::Operation::SignIn, type: :operation do
  subject(:result) { described_class.call(params: params) }

  let(:params) { create(:user).slice(:username, :password) }

  it 'succeeds' do
    expect(result.success?).to equal(true)
  end
end
