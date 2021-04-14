# frozen_string_literal: true

module API::V1::Auth::Operation
  # SignUp User operation
  class SignOut < ApplicationOperation
    step Rescue(JWTSessions::Errors::Unauthorized, handler: :set_error_info) {
      step Contract::Build(constant: API::V1::Auth::Contract::RefreshToken)
      step Contract::Validate()
      step :sign_out
    }

    def sign_out(context, params:, **)
      context[:model] = JwtSession::Destroy.new.call(params[:refresh_token])
    end

    def set_error_info(exception, options)
      options[:operation_status] = :forbidden
      options[:error] = exception.class
    end
  end
end
