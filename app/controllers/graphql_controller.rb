# frozen_string_literal: true

class GraphqlController < ::API::V1::APIController
  include GraphqlRequestParseHelpers
  def execute
    request_params = normalize_params(params[:variables])
    query, operation_name = params.values_at(:query, :operationName)
    result = ToDoListsInternshipSchema.execute(query,
                                               variables: request_params,
                                               operation_name: operation_name,
                                               context: {})
    render(json: result)
  end
end
