# frozen_string_literal: true

module API::V1::Tasks::Operation
  # Get all user's task entities operation
  class Index < ApplicationOperation
    step :find_user
    step :get_tasks

    def find_user(context, token:, **)
      user_id = JWTSessions::Token.decode(token)[0]['user_id']
      context[:user] = User.find_by(id: user_id)
    rescue JWTSessions::Errors::Unauthorized
      context[:operation_status] = :unauthorized
      false
    end

    def get_tasks(context, user:, **)
      context['model'] = user.tasks
    end
  end
end
