# frozen_string_literal: true

RSpec.describe JwtSession::GetUserIdFromToken, type: :service do
  subject(:result) { described_class.new(token).call }

  let(:token) { JwtSession::Create.new.call(user_id: user.id).login[:access] }
  let(:user) { create(:user) }

  context 'with valid token called' do
    it 'returns user_id from payload' do
      expect(result).to eq(user.id)
    end
  end

  context 'with invalid token called' do
    let(:token) { JwtSession::Create.new.call(user_id: user.id) }

    it 'raises JWTSessions::Errors::Unauthorized error' do
      expect { result }.to raise_error(
        JWTSessions::Errors::Unauthorized,
        'cannot decode the token'
      )
    end
  end
end
