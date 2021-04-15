# frozen_string_literal: true

module API::V1::Auth::Operation
  # SignUp User operation
  class SignUp < ApplicationOperation
    step Rescue(JWTSessions::Errors::Unauthorized, handler: :internal_server_error) {
      step Model(User, :new)
      step Contract::Build(constant: API::V1::Auth::Contract::SignUp)
      step Contract::Validate()
      step Contract::Persist()
      step :generate_auth_token
    }

    def generate_auth_token(context, model:, **)
      context['result'] = JwtSession::Create.new.call(user_id: model.id).login
      context[:operation_status] = :success
    end

    def internal_server_error(exception, options)
      options[:operation_status] = :internal_server_error
      options[:error] = exception.class
    end
  end
end
