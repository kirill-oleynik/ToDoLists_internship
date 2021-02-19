# frozen_string_literal: true

module API::V1::Users::Contract
  # Create user entity validation rules
  class Create < ApplicationContract
    EMAIL_REGEXP = /.+@.+\..+/.freeze
    property :username
    property :email
    property :password
    property :password_confirmation
    validation do
      params do
        required(:username).filled(:string)
        required(:email).filled(:string, format?: EMAIL_REGEXP)
      end
    end
  end
end
