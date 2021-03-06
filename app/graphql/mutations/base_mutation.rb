# frozen_string_literal: true

module Mutations
  # Base mutation class  with behaviour to be inherited by all inheritors
  class BaseMutation < GraphQL::Schema::RelayClassicMutation
    def match_operation(operation_result)
      MatchOperationResult.new.call(
        operation_result: operation_result,
        context: context
      )
    end
  end
end
