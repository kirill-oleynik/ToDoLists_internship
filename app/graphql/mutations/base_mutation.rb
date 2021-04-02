# frozen_string_literal: true

module Mutations
  class BaseMutation < GraphQL::Schema::RelayClassicMutation
    def match_operation(operation_result)
      MatchOperationResult.new.call(
        operation_result: operation_result,
        context: context
      )
    end
  end
end
