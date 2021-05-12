# frozen_string_literal: true

RSpec.describe API::V1::Tasks::Operation::Create, type: :operation do
  subject(:result) { described_class.call(token: token, params: params) }

  before { result }

  context 'with all params valid valled' do
    let(:params) { { params: attributes_for(:task) } }
    let(:token) { new_user_auth_tokens[:access] }

    it { is_expected.to be_success }

    it 'creates right task for right user' do
      user = User.find(JwtSession::GetUserIdFromToken.new(token).call)
      expect(user.tasks.count).to equal(1)
      expect(user.tasks.first.title).to eq(params[:title])
    end
  end

  context 'without token called' do
    let(:params) { attributes_for(:task) }
    let(:token) { nil }

    it { is_expected.to be_failure }

    it 'returns :unauthorized :status_code' do
      expect(result[:operation_status]).to eq(:unauthorized)
    end
  end

  context 'with empty params called' do
    let(:token) { new_user_auth_tokens[:access] }
    let(:params) { {} }

    it { is_expected.to be_success }

    it 'creates empty task for expected user' do
      user = User.find(JwtSession::GetUserIdFromToken.new(token).call)
      expect(user.tasks.count).to equal(1)
      expect(user.tasks.first.title).to eq(nil)
      expect(user.tasks.first.done).to eq(nil)
      expect(user.tasks.first.deadline).to eq(nil)
    end
  end
end
