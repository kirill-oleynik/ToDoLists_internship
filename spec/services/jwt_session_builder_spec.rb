# frozen_string_literal: true

RSpec.describe JwtSessionBuilder do
  subject(:session_builder) { described_class.new.call(user_id: user_id) }

  let(:user_id) { create(:user).id }

  it 'returns session' do
    expect(session_builder).to be_kind_of(JWTSessions::Session)
  end

  it 'uses memory to store sessions' do
    expect(session_builder.store.class)
      .to eq(JWTSessions::StoreAdapters::RedisStoreAdapter)
  end

  it 'includes payload with expected user_id' do
    expect(session_builder.payload[:user_id]).to eq(user_id)
    expect(session_builder.refresh_payload[:user_id]).to eq(user_id)
  end
end
