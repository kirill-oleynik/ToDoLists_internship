# frozen_string_literal: true

module GraphQL
  # GraphQL mutation helper methods
  module MutationHelpers
    def signup_mutation
      %(
        mutation SignUp($input: SignUp!) {
          SignUp(input: $input) {
            access
            csrf
            refresh
          }
        }
      )
    end
  end
end
