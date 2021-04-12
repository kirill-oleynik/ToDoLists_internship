# frozen_string_literal: true

RSpec.describe JwtSession::Create do
  subject(:result) { described_class.new.call(user_id: user_id) }

  let(:user_id) { create(:user).id }

  it 'returns session' do
    expect(result).to be_kind_of(JWTSessions::Session)
  end

  it 'uses Redis to store sessions' do
    expect(result.store.class)
      .to eq(JWTSessions::StoreAdapters::RedisStoreAdapter)
  end

  it 'includes payload with expected user_id' do
    expect(result.payload[:user_id]).to eq(user_id)
    expect(result.refresh_payload[:user_id]).to eq(user_id)
  end
end
