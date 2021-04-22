# frozen_string_literal: true

module API::V1::Auth::Operation
  # SignUp User operation
  class SignOut < ApplicationOperation
    step :call_contract
    step Rescue(JWTSessions::Errors::Unauthorized, handler: :set_error_info) {
      step :sign_out
    }

    def call_contract(context,params:,**)
      context['contract.default'] = API::V1::Auth::Contract::RefreshToken.new.call(params)
      context['contract.default'].success?
    end

    def sign_out(context, params:, **)
      context[:model] = JwtSession::Destroy.new.call(params[:refresh_token])
    end

    def set_error_info(exception, options)
      options[:operation_status] = :forbidden
      options[:error] = exception.class
    end
  end
end
