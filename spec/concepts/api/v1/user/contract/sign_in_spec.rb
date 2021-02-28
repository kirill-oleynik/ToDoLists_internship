# frozen_string_literal: true

RSpec.describe API::V1::User::Contract::SignIn do
  subject(:contract) { described_class.new(user) }

  let(:user) { create(:user, user_attributes) }
  let(:user_attributes) { attributes_for(:user) }

  before { contract.validate(params) }

  context 'with invalid params' do
    describe 'User with provided :username does not exist' do
      let(:params) { user_attributes.merge(username: Faker::Internet.username) }

      it 'does not succeed' do
        expect(contract.errors.empty?).to equal(false)
      end

      it 'returns expected errors' do
        expect(contract.errors.messages[:password])
          .to include(I18n.t('dry_validation.errors.rules.password.valid?'))
      end
    end

    describe 'provided password is invalid' do
      let(:params) { user_attributes.merge(password: Faker::Internet.password) }

      it 'dows not succeed' do
        expect(contract.errors.empty?).to equal(false)
      end

      it 'returns expected errors' do
        expect(contract.errors.messages[:password])
          .to include(I18n.t('dry_validation.errors.rules.password.valid?'))
      end
    end
  end

  context 'with all params valid' do
    let(:params) { user_attributes }

    it 'succeeds' do
      expect(contract.errors.empty?).to equal(true)
    end
  end
end
