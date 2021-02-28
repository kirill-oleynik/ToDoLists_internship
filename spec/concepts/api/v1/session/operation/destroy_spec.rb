# frozen_string_literal: true

RSpec.describe API::V1::Session::Operation::Destroy, type: :operation do
  describe '#call' do
    context 'when params is valid' do
      before do
        session = instance_double(JWTSessions::Session)
        allow(session).to receive(:flush_by_access_payload).and_return(true)
        allow(JWTSessions::Session).to receive(:new).and_return(session)
      end

      it 'success' do
        expect(described_class.call(payload: {})).to be_success
      end
    end
  end
end
