# frozen_string_literal: true

RSpec.describe JwtSession::Destroy do
  subject(:result) { described_class.new.call(refresh_token) }

  let(:user) { create(:user) }

  let(:refresh_token) do
    JWTSessions::Session.new(payload: payload).login[:refresh]
  end

  context 'with valid refresh token' do
    let(:payload) { { user_id: user.id } }

    it 'destroys session & returns appropriate flag' do
      expect(result).to equal(1)
    end
  end

  context 'with invalid refresh token called' do
    let(:refresh_token) { SecureRandom.uuid }

    it 'raises expected error' do
      expect { result }.to raise_error(JWTSessions::Errors::Unauthorized)
    end
  end
end
