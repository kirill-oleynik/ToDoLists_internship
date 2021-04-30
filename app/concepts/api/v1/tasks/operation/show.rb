# frozen_string_literal: true

module API::V1::Tasks::Operation
  # Show Task entity operation
  class Show < ApplicationOperation
    step :call_contract
    step :find_user
    fail :set_unauthorized_status, fail_fast: true
    step :create_task

    def call_contract(context, params:, **)
      context['contract.default'] = API::V1::Tasks::Contract::Show.new.call(params)
      context['contract.default'].success?
    end

    def find_user(context, token:, **)
      user_id = JWTSessions::Token.decode(token)[0]['user_id']
      context[:user] = User.find_by(id: user_id)
    rescue JWTSessions::Errors::Unauthorized
      false
    end

    def set_unauthorized_status(context, **)
      context[:operation_status] = :unauthorized
    end

    def create_task(context, params:, user:, **)
      context['model'] = user.tasks.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      context[:operation_status] = :not_found
      false
    end
  end
end
