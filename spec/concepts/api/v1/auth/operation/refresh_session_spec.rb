# frozen_string_literal: true

RSpec.describe API::V1::Auth::Operation::RefreshSession, type: :operation do
  subject(:result) { described_class.call(params: params) }

  let(:user) { create(:user) }
  let(:refresh_token) { JwtSession::Create.new.call(user_id: user.id).login[:refresh] }

  context 'with all params valid called' do
    let(:params) { { refresh_token: refresh_token } }

    it { is_expected.to be_success }

    it 'returns all expected tokens' do
      expect(result[:model]).to have_key(:csrf)
      expect(result[:model]).to have_key(:access)
      expect(result[:model]).to have_key(:access_expires_at)
    end
  end

  context 'without :refresh_token called' do
    let(:params) { {} }

    it { is_expected.to be_failure }
  end

  context 'with invalid :refresh_token called' do
    let(:params) { { refresh_token: Faker::Lorem.sentence } }

    it { is_expected.to be_failure }

    it 'includes information about error' do
      expect(result[:error]).to eq(JWTSessions::Errors::Unauthorized)
    end

    it 'includes info about :operation_status' do
      expect(result[:operation_status]).to eq(:forbidden)
    end
  end
end
