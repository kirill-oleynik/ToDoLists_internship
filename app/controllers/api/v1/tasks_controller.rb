# frozen_string_literal: true

module API
  module V1
    class TasksController < APIController
      before_action :authorize_access_request!

      def index
        endpoint operation: API::V1::Tasks::Operation::Index, options: { token: found_token },
                 different_handler: custom_handler(:ok, TaskSerializer)
      end

      def show
        endpoint operation: API::V1::Tasks::Operation::Show, options: { token: found_token },
                 different_handler: custom_handler(:ok, TaskSerializer)
      end

      def create
        endpoint operation: API::V1::Tasks::Operation::Create, options: { token: found_token },
                 different_handler: custom_handler(:created, TaskSerializer)
      end

      def update
        endpoint operation: API::V1::Tasks::Operation::Update, options: { token: found_token },
                 different_handler: custom_handler(:ok, TaskSerializer)
      end

      def destroy
        endpoint operation: API::V1::Tasks::Operation::Delete, options: { token: found_token },
                 different_handler: custom_handler(:ok, TaskSerializer)
      end
    end
  end
end
