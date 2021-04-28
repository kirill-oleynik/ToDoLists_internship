# frozen_string_literal: true

module API::V1::Tasks::Contract
  # Create task entity validation rules
  class Create < Dry::Validation::Contract
    params do
      required(:user_id).filled(:str?)
      optional(:title).filled(:str?)
      optional(:done).filled(:bool?)
      optional(:deadline).filled(:str?)
    end

    rule(:deadline) do
      key.failure(:future?) if value && (Date.parse(value) < Date.today)
    end
  end
end
