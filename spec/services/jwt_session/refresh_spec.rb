# frozen_string_literal: true

RSpec.describe JwtSession::Refresh do
  subject(:result) { described_class.new.call(refresh_token) }

  let(:session_data) { JwtSession::Create.new.call(user_id: create(:user).id).login }

  context 'with valid refresh token called' do
    let(:refresh_token) { session_data[:refresh] }

    it { is_expected.to be_a(Hash) }
    it { is_expected.to have_key(:access) }
    it { is_expected.to have_key(:access_expires_at) }
    it { is_expected.to have_key(:csrf) }
  end
end
