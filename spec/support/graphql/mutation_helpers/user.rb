# frozen_string_literal: true

module GraphQL
  # GraphQL mutation helper methods
  module MutationHelpers
    def signup_mutation
      %(
        mutation SignUp(
          $username: String!,
          $email: String!,
          $password: String!,
          $passwordConfirmation: String!
        ) {
          signUp(input: {
            username: $username,
            email: $email,
            password: $password,
            passwordConfirmation: $passwordConfirmation
          }) {
            access
            csrf
            refresh
          }
        }
      )
    end
  end
end
