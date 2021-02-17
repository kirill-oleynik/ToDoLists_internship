# frozen_string_literal: true

module API
  module V1
    module Users
      module Operation
        class Create < ApplicationOperation
          step Model(User, :new)
          step Trailblazer::Operation::Contract::Build(constant: API::V1::Users::Contract::Create)
          step Trailblazer::Operation::Contract::Validate()
          step Trailblazer::Operation::Contract::Persist()
        end
      end
    end
  end
end
