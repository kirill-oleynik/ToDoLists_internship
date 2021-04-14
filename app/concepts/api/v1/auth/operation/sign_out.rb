# frozen_string_literal: true

module API::V1::Auth::Operation
  # SignUp User operation
  class SignOut < ApplicationOperation
    step Contract::Build(constant: API::V1::Auth::Contract::SignOut)
    step Contract::Validate()
    step Rescue(JWTSessions::Errors::Unauthorized) {
      step :sign_out
    }
    fail :render_status

    def sign_out(context, params:, **)
      context[:model] = JwtSession::Destroy.new.call(params[:refresh_token])
    end

    def render_status(context, **)
      context[:operation_status] = :forbidden
    end
  end
end
