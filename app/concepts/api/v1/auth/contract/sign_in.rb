# frozen_string_literal: true

module API::V1::Auth::Contract
  # Sign In  user validation rules
  class SignIn < Dry::Validation::Contract
    params do
      required(:username).filled(:str?)
      required(:password).filled(:str?)
    end
  end
end
