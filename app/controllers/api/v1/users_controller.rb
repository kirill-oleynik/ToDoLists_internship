# frozen_string_literal: true

module API
  module V1
    class UsersController < ApplicationController
      def create
        endpoint operation: API::V1::User::Operation::Create, options: { params: user_params }
      end

      private

      def default_handler
        super.merge(success: ->(_result, **) { head :created })
      end

      def user_params
        params.require(:user)
      end
    end
  end
end
