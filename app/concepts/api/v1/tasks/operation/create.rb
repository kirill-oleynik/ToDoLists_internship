# frozen_string_literal: true

module API::V1::Tasks::Operation
  # Create Task entity operation
  class Create < ApplicationOperation
    step :call_contract
    step :find_user
    fail :set_not_found_operation_status, fial_fast: true
    step :create_task

    def call_contract(context, params:, **)
      context['contract.default'] = API::V1::Tasks::Contract::Create.new.call(params)
      context['contract.default'].success?
    end

    def find_user(context, params:, **)
      context[:user] = User.find_by(id: params[:user_id])
    end

    def set_not_found_operation_status(context, **)
      context[:operation_status] = :unprocessable_entity
    end

    def create_task(context, params:, **)
      context['model'] = Task.create(params)
    end
  end
end
