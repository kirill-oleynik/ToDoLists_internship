# frozen_string_literal: true

module API::V1::Comments::Contract
  # Task Comment create create and update contract
  class SetAttributes < Dry::Validation::Contract
    params do
      required(:title).filled(:str?)
    end
  end
end
