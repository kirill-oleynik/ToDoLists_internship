# frozen_string_literal: true

module API::V1::Auth::Operation
  # SignUp User operation
  class SignUp < ApplicationOperation
    step Model(User, :new)
    step Contract::Build(constant: API::V1::Auth::Contract::SignUp)
    step Contract::Validate()
    step Contract::Persist()
    step :generate_auth_token

    def generate_auth_token(ctx, model:, **)
      session = JwtSessionBuilder.new.call(user_id: model.id)
      ctx['result'] = session.login
      ctx['operation_status'] = :success
    end
  end
end
