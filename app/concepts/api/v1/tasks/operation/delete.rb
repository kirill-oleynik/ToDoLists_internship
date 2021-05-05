# frozen_string_literal: true

module API::V1::Tasks::Operation
  # Delete Task entity operation
  class Delete < ApplicationOperation
    step :call_contract
    step :find_user
    fail :set_unauthorized_status, fail_fast: true
    step :delete_task

    def call_contract(context, params:, **)
      context['contract.default'] = API::V1::Tasks::Contract::Delete.new.call(params)
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

    def delete_task(context, params:, user:, **)
      context['model'] = user.tasks.find(params[:id]).destroy
    rescue ActiveRecord::RecordNotFound
      context[:operation_status] = :not_found
      false
    end
  end
end
