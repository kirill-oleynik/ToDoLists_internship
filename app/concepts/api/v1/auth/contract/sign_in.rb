# frozen_string_literal: true

module API::V1::Auth::Contract
  # Sign In  user validation rules
  class SignIn < ApplicationContract
    property :username, virtual: true
    property :password, virtual: true
    validation :default do
      params do
        required(:username).filled(:str?)
        required(:password).filled(:str?)
      end
    end
  end
end
