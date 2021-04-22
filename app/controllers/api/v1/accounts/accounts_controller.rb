# frozen_string_literal: true

module API
  module V1
    module Accounts
      class AccountsController < APIController
        def default_handler
          super.merge(
            success: ->(result, **opts) { render json: result[:result], **opts, status: :created },
            unauthorized: ->(_result, **opts) { render json: { password: :invalid }, **opts, status: :unauthorized },
            invalid: lambda do |result, **|
              render json: result['contract.default'].errors.messages, status: :unprocessable_entity
            end
          )
        end
      end
    end
  end
end
