# frozen_string_literal: true

RSpec.describe JwtSession::Refresh, type: :service do
  subject(:result) { described_class.new(arguments).call(refresh_token) }

  let(:arguments) { {} }

  context 'with valid refresh token called' do
    let(:refresh_token) { new_user_auth_tokens[:refresh] }

    it { is_expected.to be_a(Hash) }
    it { is_expected.to have_key(:access) }
    it { is_expected.to have_key(:access_expires_at) }
    it { is_expected.to have_key(:csrf) }

    context 'when initialized with payload' do
      let(:arguments) { { payload: { user_id: create(:user).id } } }

      it { is_expected.to be_a(Hash) }
      it { is_expected.to have_key(:access) }
      it { is_expected.to have_key(:access_expires_at) }
      it { is_expected.to have_key(:csrf) }
    end
  end
end
