# frozen_string_literal: true

module Requests
  # methods for convenient response handling
  module JsonHelpers
    def parsed_body
      JSON.parse(response.body)
    end

    def graphql_response_error_status_code
      parsed_body['errors'][0]['extensions']['code']
    end

    def error_info
      parsed_body['errors'][0]['message']
    end
  end
end
