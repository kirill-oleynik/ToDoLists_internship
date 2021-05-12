# frozen_string_literal: true

module Requests
  # Authentication helpers
  module AuthHelpers
    def new_user_auth_tokens(user: create(:user))
      JwtSession::Create.new.call(user_id: user.id).login
    end
  end

  # methods for convenient response handling
  module JsonHelpers
    def parsed_body
      JSON.parse(response.body)
    end

    def graphql_response_error_status_code
      parsed_body['errors'][0]['extensions']['code']
    end
  end
end
