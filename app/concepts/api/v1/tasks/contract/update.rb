# frozen_string_literal: true

module API::V1::Tasks::Contract
  # Create task entity validation rules
  class Update < Dry::Validation::Contract
    params do
      optional(:title).filled(:str?)
      optional(:done).filled(:bool?)
      optional(:deadline).filled(:str?)
    end

    rule(:deadline) do
      key.failure(:future?) if value && (Date.parse(value) < Date.today)
    end
  end
end
