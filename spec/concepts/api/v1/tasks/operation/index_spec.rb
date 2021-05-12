# frozen_string_literal: true

RSpec.describe API::V1::Tasks::Operation::Index, type: :operation do
  subject(:result) { described_class.call(token: token) }

  let(:token) { JwtSession::Create.new.call(user_id: user.id).login[:access] }

  before { result }

  context 'with all params valid called' do
    let(:user) { create_user_with_tasks(tasks_count: 10) }

    it { is_expected.to be_success }

    it 'returns list of user tasks' do
      expect(result['model']).to be_an(ActiveRecord::Associations::CollectionProxy)
      expect(result['model'].length).to equal(10)
      expect(
        result['model'].all? { |task| task.user_id == user.id }
      ).to equal(true)
    end
  end

  context 'when user has no tasks' do
    let(:user) { create(:user) }

    it { is_expected.to be_success }

    it 'returns empty list' do
      expect(result['model']).to be_an(ActiveRecord::Associations::CollectionProxy)
      expect(result['model']).to be_empty
    end
  end

  context 'with invalid user id called' do
    let(:token) { SecureRandom.uuid }

    it { is_expected.to be_failure }

    it 'returns :unauthorized :operation_status' do
      expect(result[:operation_status]).to eq(:unauthorized)
    end
  end
end
