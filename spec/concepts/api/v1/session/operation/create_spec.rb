# frozen_string_literal: true

RSpec.describe API::V1::Session::Operation::Create, type: :operation do
  subject(:operation) { described_class.call(params: params) }

  before { create(:user, user_attributes) }

  let(:user_attributes) { attributes_for(:user) }

  context 'with all params valid' do
    let(:params) { user_attributes }

    it 'succeeds' do
      expect(operation).to be_success
    end
  end

  context 'with invalid params' do
    describe ':password is not provided' do
      let(:params) { user_attributes.slice(:username) }

      it 'does not succeed' do
        expect(operation).to be_failure
      end
    end

    describe ':username is not provided' do
      let(:params) { user_attributes.slice(:password) }

      it 'does not succeed' do
        expect(operation).to be_failure
      end
    end

    describe ':username is invalid' do
      let(:params) do
        let(:params) do
          user_attributes.slice(:password)
                         .merge(username: Faker::Internet.username)
        end

        it 'does not succeed' do
          expect(operation).to be_failure
        end
      end
    end

    describe ':password is invalid' do
      let(:params) do
        user_attributes.slice(:username)
                       .merge(password: Faker::Internet.password)
      end

      it 'does not succeed' do
        expect(operation).to be_failure
      end
    end

    describe 'with all params invalid' do
      let(:params) do
        {
          username: Faker::Internet.username,
          password: Faker::Internet.password
        }
      end

      it 'does not succeed' do
        expect(operation).to be_failure
      end
    end
  end
end
