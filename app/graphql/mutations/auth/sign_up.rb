# frozen_string_literal: true

module Mutations
  module Auth
    # SignUp mutation
    class SignUp < BaseMutation
      type Types::AuthTokenType

      description I18n.t('graphql.mutations.user.sign_up.desc')

      argument :input, Types::Inputs::Auth::SignUp, required: true

      def resolve(input:)
        match_operation(API::V1::Auth::Operation::SignUp.call(params: input.to_h))
      end
    end
  end
end
