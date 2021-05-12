# frozen_string_literal: true

module API::V1::Tasks::Operation
  # Create Task entity operation
  class Create < ApplicationOperation
    step :call_contract
    step :find_user
    fail :set_unauthorized_status, fail_fast: true
    step :create_task

    def call_contract(context, params:, **)
      context['contract.default'] = API::V1::Tasks::Contract::SetAttributes.new.call(params[:task])
      context['contract.default'].success?
    end

    def find_user(context, token:, **)
      user_id = JwtSession::GetUserIdFromToken.new(token).call
      context[:user] = User.find_by(id: user_id)
    rescue JWTSessions::Errors::Unauthorized
      false
    end

    def set_unauthorized_status(context, **)
      context[:operation_status] = :unauthorized
    end

    def create_task(context, params:, user:, **)
      context['model'] = user.tasks.create(params[:task])
    end
  end
end
