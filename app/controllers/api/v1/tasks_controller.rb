# frozen_string_literal: true

module API
  module V1
    class TasksController < APIController
      before_action :authorize_access_request!

      def create
        endpoint operation: API::V1::Tasks::Operation::Create, options: { token: found_token },
                 different_handler: create_task_handler
      end

      def show
        endpoint operation: API::V1::Tasks::Operation::Show, options: { token: found_token }
      end

      private

      def create_task_handler
        default_handler.merge(
          success: ->(result, **opts) { render json: result['model'], **opts, status: 201 }
        )
      end
    end
  end
end
