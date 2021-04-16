# frozen_string_literal: true

module API::V1::Auth::Operation
  # SignUp User operation
  class RefreshSession < ApplicationOperation
    step Contract::Build(constant: API::V1::Auth::Contract::RefreshToken)
    step Contract::Validate()
    step Rescue(JWTSessions::Errors::Unauthorized, handler: :render_status) {
      step :refresh_session
    }

    def refresh_session(context, params:, **)
      context[:model] = JwtSession::Refresh.new.call(params[:refresh_token])
    end

    def render_status(exception, options)
      options[:error] = exception.class
      options[:operation_status] = :forbidden
    end
  end
end
