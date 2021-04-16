# frozen_string_literal: true

module API
  module V1
    module Accounts
      class RegistrationsController < APIController
        def create
          endpoint operation: API::V1::Auth::Operation::SignUp
        end

        def default_handler
          super.merge(
            success: ->(result, **opts) { render json: result[:result], **opts, status: :created },
            invalid: lambda do |result, **_|
              render json: result['contract.default'].errors.messages, status: :unprocessable_entity
            end
          )
        end
      end
    end
  end
end
