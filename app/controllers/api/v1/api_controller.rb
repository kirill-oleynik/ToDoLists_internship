# frozen_string_literal: true

module API
  module V1
    class APIController < ApplicationController
      include SimpleEndpoint::Controller

      private

      def default_options
        { params: params }
      end

      def default_cases
        {
          success: ->(result) { result.success? },
          invalid: ->(result) { result.failure? },
          forbidden: ->(result) { result.failure? && result[:operation_status] == :forbidden },
          created: ->(result) { result.succes? && result[:operation_status] == :created }
        }
      end

      def default_handler
        {
          success: ->(result, **opts) { render json: result['model'], **opts, status: 200 },
          invalid: lambda { |result, **|
                     render json: result['contract.default'], serializer: ErrorSerializer,
                            status: :unprocessable_entity
                   },
          forbidden: ->(_result, **) { head(:forbidden) },
          created: ->(result, **opts) { render json: result[:result], **opts, status: 201 }
        }
      end
    end
  end
end
