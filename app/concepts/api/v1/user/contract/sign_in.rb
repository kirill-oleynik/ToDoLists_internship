# frozen_string_literal: true

module API
  module V1
    module User
      module Contract
        # User sign in contract
        class SignIn < ApplicationContract
          delegate :authenticate, to: :model
          property :password
          property :username

          validation :default do
            params do
              required(:password).filled(:str?)
              optional(:username).filled(:str?)
            end
            rule(:password) do
              user = ::User.find_by(username: values[:username])
              key.failure(:valid?) unless user.authenticate(values[:password])
            rescue NoMethodError
              key.failure(:valid?)
            end
          end
        end
      end
    end
  end
end
