# frozen_string_literal: true

module API::V1::Auth::Operation
  # refresh session operation
  class RefreshSession < ApplicationOperation
    step :call_contract
    step Rescue(JWTSessions::Errors::Unauthorized, handler: :set_operation_status) {
      step :create_payload
      step :refresh_session
    }

    def call_contract(context, params:, **)
      context['contract.default'] = API::V1::Auth::Contract::RefreshToken.new.call(params)
    end

    def create_payload(context, params:, **)
      user_id = JWTSessions::Token.decode(params[:refresh_token]).first['user_id']
      return unless User.exists?(user_id)

      context[:payload] = { user_id: user_id }
    end

    def refresh_session(context, payload:, params:, **)
      context[:model] = JwtSession::Refresh.new(payload: payload).call(params[:refresh_token])
    end

    def set_operation_status(exception, options)
      options[:error] = exception.class
      options[:operation_status] = :forbidden
    end
  end
end
