# frozen_string_literal: true

module API::V1::Auth::Operation
  # SignOut User operation
  class SignOut < ApplicationOperation
    step :call_contract
    step Rescue(JWTSessions::Errors::Unauthorized, handler: :render_status) {
      step :refresh_session
    }

    def call_contract(context, **)
      context['contract.default'] = API::V1::Auth::Contract::RefreshToken.new.call(context)
    end

    def refresh_session(context, **)
      context[:model] = JwtSession::Refresh.new.call(context[:params][:refresh_token])
    end

    def render_status(exception, options)
      options[:error] = exception.class
      options[:operation_status] = :forbidden
    end
  end
end
