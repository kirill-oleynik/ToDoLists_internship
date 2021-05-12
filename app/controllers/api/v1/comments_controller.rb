# frozen_string_literal: true

module API
  module V1
    class CommentsController < APIController
      before_action :authorize_access_request!

      def create
        endpoint operation: API::V1::Comments::Operation::Create, options: { token: found_token },
                 different_handler: custom_handler(:created, CommentSerializer)
      end

      def update
        endpoint operation: API::V1::Comments::Operation::Update, options: { token: found_token },
                 different_handler: custom_handler(:ok, CommentSerializer)
      end

      def destroy
        endpoint operation: API::V1::Comments::Operation::Delete, options: { token: found_token },
                 different_handler: custom_handler(:ok, CommentSerializer)
      end
    end
  end
end
