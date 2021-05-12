# frozen_string_literal: true

module API::V1::Comments::Operation
  # Delete Task Comment entity operation
  class Delete < ApplicationOperation
    step :find_user
    step :delete_comment

    def find_user(context, token:, **)
      user_id = JwtSession::GetUserIdFromToken.new(token).call
      context[:user] = User.find_by(id: user_id)
    rescue JWTSessions::Errors::Unauthorized
      context[:operation_status] = :unauthorized
      false
    end

    def delete_comment(context, user:, params:, **)
      context[:model] = user.tasks.find(params[:task_id]).comments.find(params[:id]).destroy
    rescue ActiveRecord::RecordNotFound
      context[:operation_status] = :not_found
      false
    end
  end
end
