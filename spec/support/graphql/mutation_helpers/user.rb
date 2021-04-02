# frozen_string_literal: true

module GraphQL
  # GraphQL mutation helper methods
  module MutationHelpers
    def signup_mutation
      %(
        mutation($username: String!) {
          signUp(username: $username) {
            access
            csrf
            refresh
          }
        }
      )
    end
  end
end
