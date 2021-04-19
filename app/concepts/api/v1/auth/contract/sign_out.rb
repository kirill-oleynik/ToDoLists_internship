# frozen_string_literal: true

module API::V1::Auth::Contract
  # Sign In  user validation rules
  class SignOut < Dry::Validation::Contract
    params do
      required(:refresh_token).filled(:str?)
    end
  end
end
