# frozen_string_literal: true

module API::V1::Auth::Operation
  # SignIn User operation
  class SignIn < ApplicationOperation
    step :call_contract
    step :find_user
    fail :render_not_found_error, fail_fast: true
    step :auth_user
    fail :set_error_info
    step :create_session

    def call_contract(context, params:, **); end

    def find_user(context, params:, **)
      context[:user] = User.find_by(username: params[:username])
    end

    def render_not_found_error(context, **)
      context[:operation_status] = :not_found
    end

    def auth_user(_context, params:, user:, **)
      user.authenticate(params[:password])
    end

    def set_error_info(context, **)
      context[:operation_status] = :unauthorized
    end

    def create_session(context, user:, **)
      session = JwtSession::Create.new.call(user_id: user.id)
      context['result'] = session.login
      context['operation_status'] = :success
    end
  end
end
