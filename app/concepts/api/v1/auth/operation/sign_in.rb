# frozen_string_literal: true

module API::V1::Auth::Operation
  # SignUp User operation
  class SignIn < ApplicationOperation
    CONTRACT = API::V1::Auth::Contract::SignIn
    # step Contract::Build(constant: API::V1::Auth::Contract::SignIn)
    # step Contract::Validate()
    step :call_contract
    step Rescue(ActiveRecord::RecordNotFound,NoMethodError, handler: :set_error_info) {
      step :create_session
    }

    def call_contract(context,params:,**)
      request_params = params.slice(:username, :password)
      context['contract.default'] = CONTRACT.new.(request_params)
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
