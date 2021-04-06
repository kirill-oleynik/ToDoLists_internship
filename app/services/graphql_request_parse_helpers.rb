# frozen_string_literal: true

# GraphQL request parse helper methods
module GraphqlRequestParseHelpers
  def normalize_params(variables_param)
    return {} unless variables_param

    case variables_param
    when String
      variables_param.present? ? normalize_params(JSON.parse(variables_param)) : {}
    when Hash, ActionController::Parameters
      variables_param
    else
      raise ArgumentError, "Unexpected parameter: #{variables_param}"
    end
  end
end
