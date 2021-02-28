# frozen_string_literal: true

RSpec.describe ::API::V1::GenerateHeaders do
  subject(:service) { described_class.call(user: user) }

  let(:user) { create(:user) }

  it 'returns Authorization header' do
    expect(service).to be_a(Hash)
    expect(service).to be_key(JWTSessions.access_header)
  end
end
