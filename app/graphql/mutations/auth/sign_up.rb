# frozen_string_literal: true

module Mutations
  module Auth
    # SignUp mutation
    class SignUp < BaseMutation
      type Types::AuthTokenType

      description I18n.t('graphql.mutations.user.sign_up.desc')

      argument :username,
               String,
               required: true
      #  description: I18n.t("#{I18N_PATH}.args.username")

      argument :email,
               String,
               required: true
      #  description: I18n.t("#{I18N_PATH}.args.email")

      argument :password,
               String,
               required: true
      #  description: I18n.t("#{I18N_PATH}.args.password")

      argument :password_confirmation,
               String,
               required: true
      #  description: I18n.t("#{I18N_PATH}.args.password_confirmation")

      def resolve(username:, email:, password:, password_confirmation:)
        input = { username: username, email: email, password: password, password_confirmation: password_confirmation }
        match_operation(API::V1::Auth::Operation::SignUp.call(params: input))
      end
    end
  end
end
