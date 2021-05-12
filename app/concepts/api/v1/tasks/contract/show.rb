# frozen_string_literal: true

module API::V1::Tasks::Contract
  # Show Task entity validation rules
  class Show < Dry::Validation::Contract
    params do
      required(:id).filled(:str?)
    end
  end
end
