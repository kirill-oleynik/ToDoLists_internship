# frozen_string_literal: true

module API::V1::Auth::Operation
  # SignUp User operation
  class SignUp < ApplicationOperation
    step Model(User, :new)
    step Contract::Build(constant: API::V1::Auth::Contract::SignUp)
    step Contract::Validate()
    # rubocop: disable Style/SignalException
    # rubocop: disable Lint/UnreachableCode
    fail :set_operation_failure_status
    step Contract::Persist()
    # rubocop: enable Style/SignalException
    # rubocop: enable Lint/UnreachableCode
    step :generate_auth_token

    def set_operation_failure_status(context, **)
      context['operation_status'] = :unprocessable_entity
    end

    def generate_auth_token(ctx, model:, **)
      session = JwtSession::Build.new.call(user_id: model.id)
      ctx['result'] = session.login
      ctx['operation_status'] = :success
    end
  end
end
