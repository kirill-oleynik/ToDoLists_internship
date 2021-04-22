# frozen_string_literal: true

module API
  module V1
    module Accounts
      class SessionsController < AccountsController
        def create
          endpoint operation: API::V1::Auth::Operation::SignIn
        end

        def update
          endpoint operation: API::V1::Auth::Operation::RefreshSession
        end

        def destroy
          endpoint operation: API::V1::Auth::Operation::SignOut,
                   different_handler: destroy_handler
        end

        private

        def destroy_handler
          {
            success: ->(result, **opts) { render json: result[:result], **opts, status: :ok }
          }
        end
      end
    end
  end
end
