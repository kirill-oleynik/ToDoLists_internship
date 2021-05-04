# frozen_string_literal: true

module API::V1::Comments::Operation
  # Create Task Comment entity operation
  class Update < ApplicationOperation
    step :call_contract
    step :find_user
    step :update_comment

    def call_contract(context, params:, **)
      context['contract.default'] = API::V1::Comments::Contract::SetAttributes.new.call(params[:comment])
      context['contract.default'].success?
    end

    def find_user(context, token:, **)
      user_id = JWTSessions::Token.decode(token)[0]['user_id']
      context[:user] = User.find_by(id: user_id)
    rescue JWTSessions::Errors::Unauthorized
      context[:operation_status] = :unauthorized
      false
    end

    def update_comment(context, user:, params:, **)
      comment = user.tasks.find(params[:task_id]).comments.find(params[:id])
      context[:model] = comment if comment.update(params[:comment])
    rescue ActiveRecord::RecordNotFound
      context[:operation_status] = :not_found
      false
    end
  end
end
