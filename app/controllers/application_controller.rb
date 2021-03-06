# frozen_string_literal: true

class ApplicationController < ActionController::API
  include JWTSessions::RailsAuthorization
  rescue_from JWTSessions::Errors::Unauthorized, with: :not_authorized
  include SimpleEndpoint::Controller

  private

  def default_cases
    {
      success: ->(result) { result.success? },
      invalid: ->(result) { result.failure? }
    }
  end

  def default_handler
    {
      success: ->(result, **opts) { render json: result['model'], **opts, status: 200 },
      invalid: lambda { |result, **|
                 render json: result['contract.default'].errors, serializer: ErrorSerializer,
                        status: :unprocessable_entity
               }
    }
  end

  def not_authorized
    render json: { error: 'Not authorized' }, status: :unauthorized
  end

  def endpoint_options
    { params: params.to_unsafe_hash }.merge(token: found_token)
  end
end
