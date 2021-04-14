# frozen_string_literal: true

module API
  module V1
    class APIController < ApplicationController
      include SimpleEndpoint::Controller

      private

      def default_cases
        {
          success: ->(result) { result.success? },
          invalid: ->(result) { result.failure? },
          forbidden: ->(result) { result.failure? && result[:operation_status] == :forbidden }
        }
      end

      def default_handler
        {
          success: ->(result, **opts) { render json: result['model'], **opts, status: 200 },
          invalid: lambda { |result, **|
                     render json: result['contract.default'].errors, serializer: ErrorSerializer,
                            status: :unprocessable_entity
                   },
          forbidden: ->(_result, **) { head(:forbidden) }
        }
      end
    end
  end
end
