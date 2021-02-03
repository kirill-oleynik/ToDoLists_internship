# frozen_string_literal: true

module Requests
  # methods for convenient response handling
  module JsonHelpers
    def parsed_body
      JSON.parse(response.body)
    end
  end
end
