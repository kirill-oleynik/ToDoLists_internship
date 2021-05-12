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
        endpoint operation: API::V1::Comments::Operation::Update, options: { token: found_token },
                 different_handler: update_comment_handler
      end

      def destroy
        endpoint operation: API::V1::Comments::Operation::Delete, options: { token: found_token },
                 different_handler: destroy_comment_handler
      end

      private

      def create_comment_handler
        default_handler.merge(
          success: ->(result, **opts) { render json: CommentSerializer.new(result['model']), **opts, status: 201 }
        )
      end

      def update_comment_handler
        default_handler.merge(
          success: ->(result, **opts) { render json: CommentSerializer.new(result['model']), **opts, status: 200 }
        )
      end

      def destroy_comment_handler
        default_handler.merge(
          success: ->(result, **opts) { render json: CommentSerializer.new(result['model']), **opts, status: 200 }
        )
      end
    end
  end
end
