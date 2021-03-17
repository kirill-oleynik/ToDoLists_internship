# frozen_string_literal: true

module GraphQL
  # GraphQL mutation helper methods
  module MutationHelpers
    def user_signup_mutation
      %(
        mutation userSignUp($input: UserSignUpInput!) {
          userSignUp(input: $input) {
            access
            csrf
            refresh
          }
        }
      )
    end
  end
end
