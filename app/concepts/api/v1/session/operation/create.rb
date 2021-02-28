# frozen_string_literal: true

module API
  module V1
    module Session
      module Operation
        # Create Session operation
        class Create < ApplicationOperation
          step Model(::User, :find_by, :username), fail_fast: true
          step Contract::Build(constant: API::V1::User::Contract::SignIn)
          step Contract::Validate()
          step :generate_headers
          step :result

          def generate_headers(ctx, model:, **)
            ctx[:headers] = API::V1::GenerateHeaders.call(user: model)
          end

          def result(ctx, model:, **)
            ctx[:result] = model
          end
        end
      end
    end
  end
end
