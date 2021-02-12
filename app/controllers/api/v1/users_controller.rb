# frozen_string_literal: true

module API
  module V1
    class UsersController < ApiController
      def create
        endpoint operation: API::V1::Users::Operation::Create
      end

      private

      def default_handler
        super.merge(success: ->(_result, **) { head :created })
      end
    end
  end
end
