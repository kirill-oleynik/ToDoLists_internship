# frozen_string_literal: true

module API::V1::Tasks::Contract
  # Delete Task entity validation rules
  class Delete < Dry::Validation::Contract
    params do
      required(:id).filled(:str?)
    end
  end
end
