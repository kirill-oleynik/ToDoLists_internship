# frozen_string_literal: true

module API::V1::Auth::Contract
  # RefreshToken validation rules
  class RefreshToken < Dry::Validation::Contract
    params do
      required(:refresh_token).filled(:str?)
    end
  end
end
