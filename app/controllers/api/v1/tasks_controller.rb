# frozen_string_literal: true

module API
  module V1
    class TasksController < APIController
      before_action :authorize_access_request!

      def index
        endpoint operation: API::V1::Tasks::Operation::Index, options: { token: found_token },
                 different_handler: index_handler
      end

      def show
        endpoint operation: API::V1::Tasks::Operation::Show, options: { token: found_token },
                 different_handler: show_handler
      end

      def create
        endpoint operation: API::V1::Tasks::Operation::Create, options: { token: found_token },
                 different_handler: create_task_handler
      end

      def update
        endpoint operation: API::V1::Tasks::Operation::Update, options: { token: found_token },
                 different_handler: update_task_handler
      end

      def destroy
        endpoint operation: API::V1::Tasks::Operation::Delete, options: { token: found_token },
                 different_handler: destroy_handler
      end

      private

      def index_handler
        default_handler.merge(
          success: ->(result, **opts) { render json: TaskSerializer.new(result['model']), **opts, status: 200 }
        )
      end

      def destroy_handler
        default_handler.merge(
          success: ->(result, **opts) { render json: TaskSerializer.new(result['model']), **opts, status: 200 }
        )
      end

      def show_handler
        default_handler.merge(
          success: ->(result, **opts) { render json: TaskSerializer.new(result['model']), **opts, status: 200 }
        )
      end

      def create_task_handler
        default_handler.merge(
          success: ->(result, **opts) { render json: TaskSerializer.new(result['model']), **opts, status: 201 }
        )
      end

      def update_task_handler
        default_handler.merge(
          success: ->(result, **opts) { render json: TaskSerializer.new(result['model']), **opts, status: 200 }
        )
      end
    end
  end
end
