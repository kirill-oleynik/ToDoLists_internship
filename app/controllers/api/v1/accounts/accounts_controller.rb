# frozen_string_literal: true

module API
  module V1
    module Accounts
      class AccountsController < APIController
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
