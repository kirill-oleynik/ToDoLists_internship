# frozen_string_literal: true

module API
  module V1
    module Accounts
      class AccountsController < APIController
        include JWTSessions::RailsAuthorization
        rescue_from JWTSessions::Errors::Unauthorized, with: :not_authorized

        def default_handler
          super.merge(
            success: ->(result, **opts) { render json: result[:result], **opts, status: :created },
            unauthorized: ->(_result, **opts) { render json: { password: :invalid }, **opts, status: :unauthorized },
            invalid: lambda do |result, **|
              render json: result['contract.default'].errors.messages, status: :unprocessable_entity
            end
          )
        end

        private

        def not_authorized
          render json: { error: 'Not authorized' }, status: :unauthorized
        end
      end
    end
  end
end
