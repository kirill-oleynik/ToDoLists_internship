# frozen_string_literal: true

module API::V1::Auth::Operation
  # SignUp User operation
  class SignOut < ApplicationOperation
    step Contract::Build(constant: API::V1::Auth::Contract::SignOut)
    step Contract::Validate()
    step :sign_out

    def sign_out(context, params:, **)
      session = JWTSessions::Session.new
      session.flush_by_token(params[:refresh_token])
    rescue JWTSessions::Errors::Unauthorized
      context['operation_status'] = :failure
      context['errors'] = 'JWTSessions::Errors::Unauthorized'
    end
  end
end
