# frozen_string_literal: true

module API::V1::Tasks::Operation
  # Update Task entity operation
  class Update < ApplicationOperation
    step :call_contract
    step :find_user
    step :update_task

    def call_contract(context, params:, **)
      context['contract.default'] = API::V1::Tasks::Contract::SetAttributes.new.call(params[:task])
      context['contract.default'].success?
    end

    def find_user(context, token:, **)
      user_id = JwtSession::GetUserIdFromToken.new(token).call
      context[:user] = User.find_by(id: user_id)
    rescue JWTSessions::Errors::Unauthorized
      context[:operation_status] = :unauthorized
      false
    end

    def update_task(context, params:, user:, **)
      user.tasks.find(params[:id]).update(params[:task])
      context['model'] = user.tasks.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      context[:operation_status] = :not_found
      false
    end
  end
end
