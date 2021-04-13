# frozen_string_literal: true

module API::V1::Auth::Operation
  # SignUp User operation
  class SignIn < ApplicationOperation
    step Contract::Build(constant: API::V1::Auth::Contract::SignIn)
    step Contract::Validate()
    step :create_session

    def create_session(context, params:, **)
      user = User.find_by(username: params[:username])
                 .authenticate(params[:password])
      session = JwtSession::Create.new.call(user_id: user.id)
      context['result'] = session.login
      context['operation_status'] = :success
    end
  end
end
