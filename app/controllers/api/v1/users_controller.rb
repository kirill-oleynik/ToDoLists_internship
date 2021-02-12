# frozen_string_literal: true

module API
  module V1
    class UsersController < Apicontroller
      def create
        endpoint operation: User::Create
      end

      private

      def default_handler
        super.merge(success: ->(result, **) { head :created })
      end
    end
  end
end
