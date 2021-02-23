# frozen_string_literal: true

module API::V1::Users::Contract
  # Create user entity validation rules
  class Create < ApplicationContract
    property :username
    property :email
    property :password
    property :password_confirmation
    validation :default do
      params do
        required(:username).filled(:string)
        required(:email).filled(:string, format?: Constants::User::EMAIL_REGEXP)
        required(:password).filled(:str?, min_size?: Constants::User::PASSWORD_MIN_SIZE)
        required(:password_confirmation).filled(:str?)
      end
      rule(:username) do
        key.failure(:exists?) if ::User.exists?(username: value)
      end
      rule(:email) do
        key.failure(:exists?) if ::User.exists?(email: value)
      end
      rule(:password_confirmation, :password) do
        key.failure(:eql?) if values[:password] != values[:password_confirmation]
      end
    end
  end
end
