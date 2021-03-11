# frozen_string_literal: true

class GraphQLController < ::API::V1::APIController
  def execute
    variables = prepare_variables(params[:variables])
    query, operation_name = params.values_at(:query, operationName)
    result = ToDoListsInternshipSchema.execute(query, variables: variables, context: {},
                                                      operation_name: operation_name)
    render json: result
  end

  private

  def prepare_variables(variables_param)
    return {} unless variables_param

    case variables_param
    when String
      variables_param.present? ? variables_param(JSON.parse(variables_param)) : {}
    when Hash, ActionController::Parameters
      variables_param
    else
      raise ArgumentError, "Unexpected parameter: #{variables_param}"
    end
  end
end
