# frozen_string_literal: true

# Create User entity operation
module API::V1::Users::Operation
  # Create User entity operation
  class Create < ApplicationOperation
    step Model(User, :new)
    step Contract::Build(constant: API::V1::Users::Contract::Create)
    step Contract::Validate()
    step Contract::Persist()
  end
end
