# frozen_string_literal: true

module Types
  # Mutation entry point type defiition
  class MutationType < Types::BaseObject
    field :sign_up, mutation: Mutations::Auth::SignUp
  end
end
