# frozen_string_literal: true

module API::V1::Auth::Operation
  # SignUp User operation
  class SignOut < ApplicationOperation
    step Contract::Build(constant: API::V1::Auth::Contract::SignOut)
    step Contract::Validate()
    step :sign_out

    def sign_out(context, params:, **)
      JwtSession::Destroy.new.call(params[:refresh_token])
    rescue JWTSessions::Errors::Unauthorized
      context['operation_status'] = :failure
      context['errors'] = 'JWTSessions::Errors::Unauthorized'
    end
  end
end
