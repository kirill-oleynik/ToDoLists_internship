# frozen_string_literal: true

module API::V1::Auth::Operation
  # SignUp User operation
  class RefreshSession < ApplicationOperation
    step Contract::Build(constant: API::V1::Auth::Contract::RefreshToken)
    step Contract::Validate()
    step :refresh_session

    def refresh_session(context, params:, **)
      JwtSession::Refresh.new.call(params[:refresh_token])
    rescue JWTSessions::Errors::Unauthorized
      context['operation_status'] = :failure
      context['errors'] = 'JWTSessions::Errors::Unauthorized'
    end
  end
end
