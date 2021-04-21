# frozen_string_literal: true

module API
  module V1
    class APIController < ApplicationController
      include SimpleEndpoint::Controller

      private

      def endpoint_options
        { params: params.to_unsafe_hash }
      end

      def default_cases
        {
          unauthorized: ->(result) { result.failure? && result[:operation_status] == :unauthorized },
          forbidden: ->(result) { result.failure? && result[:operation_status] == :forbidden },
          not_found: ->(result) { result.failure? && result[:operation_status] == :not_found },
          invalid: ->(result) { result.failure? },
          created: ->(result) { result.success? && result[:operation_status] == :created },
          success: ->(result) { result.success? }
        }
      end

      def default_handler
        {
          success: ->(result, **opts) { render json: result['model'], **opts, status: 200 },
          invalid: lambda { |result, **|
                     render json: result['contract.default'], serializer: ErrorSerializer, status: :unprocessable_entity
                   },
          forbidden: ->(_result, **) { head(:forbidden) },
          not_found: ->(_result, **) { head(:not_found) },
          unauthorized: ->(_result, **) { head(:unauthorized) },
          created: ->(result, **opts) { render json: result[:result], **opts, status: 201 }
        }
      end
    end
  end
end
