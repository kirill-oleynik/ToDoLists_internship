# frozen_string_literal: true

RSpec.describe User, type: :model do
  subject(:user) { create(:user, username: 'username', email: 'email') }

  describe 'Instance methods' do
    describe 'getters' do
      it '#username' do
        expect(user.username).to eq('username')
      end

      it '#email' do
        expect(user.email).to eq('email')
      end
    end

    describe 'setters' do
      before do
        user.username = 'username-2'
        user.email = 'email-2'
      end

      it '#username' do
        expect(user.username).to eq('username-2')
      end

      it '#email' do
        expect(user.email).to eq('email-2')
      end
    end
  end
end
