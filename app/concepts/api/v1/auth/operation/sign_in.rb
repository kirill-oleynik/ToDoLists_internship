# frozen_string_literal: true

module API::V1::Auth::Operation
  # SignUp User operation
  class SignIn < ApplicationOperation
    step :call_contract
    step Rescue(ActiveRecord::RecordNotFound, handler: :set_error_info) {
      step :create_session
    }

    def call_contract(context, params:, **)
      context['contract.default'] = API::V1::Auth::Contract::SignIn.new.call(params.to_unsafe_hash)
      context['contract.default'].success?
    end

    def create_session(context, params:, **)
      user = User.find_by!(username: params[:username])
                 .authenticate(params[:password])
      session = JwtSession::Create.new.call(user_id: user.id)
      context['result'] = session.login
      context['operation_status'] = :success
    end

    def set_error_info(exception, options)
      options[:operation_status] = :unauthorized
      options[:error] = exception.class
    end
  end
end
