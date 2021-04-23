# frozen_string_literal: true

module API
  module V1
    module Accounts
      class SessionsController < AccountsController
        before_action :authorize_refresh_request!, only: %i[update destroy]

        def create
          endpoint operation: API::V1::Auth::Operation::SignIn
        end

        def update
          endpoint operation: API::V1::Auth::Operation::RefreshSession, options: refresh_token
        end

        def destroy
          endpoint operation: API::V1::Auth::Operation::SignOut, options: refresh_token,
                   different_handler: destroy_handler
        end

        private

        def refresh_token
          { params: { refresh_token: found_token } }
        end

        def destroy_handler
          {
            success: ->(result, **opts) { render json: result[:result], **opts, status: :ok }
          }
        end
      end
    end
  end
end
