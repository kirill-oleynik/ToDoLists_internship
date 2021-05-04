# frozen_string_literal: true

module API
  module V1
    class CommentsController < APIController
      before_action :authorize_access_request!

      def create
        endpoint operation: API::V1::Comments::Operation::Create, options: { token: found_token },
                 different_handler: create_comment_handler
      end

      def update
        endpoint operation: API::V1::Comments::Operation::Update, options: { token: found_token }
      end

      private

      def create_comment_handler
        default_handler.merge(
          success: ->(result, **opts) { render json: result['model'], **opts, status: 201 }
        )
      end
    end
  end
end
