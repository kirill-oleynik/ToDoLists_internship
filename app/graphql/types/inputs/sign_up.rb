# frozen_string_literal: true

module Types
  module Inputs
    # User Sign up input type
    class SignUpInput < ::Types::Base::InputObject
      I18N_PATH = 'graphql.inputs.sign_up_input'
      graphql_name 'SignUpInput'

      description I18n.t("#{I18N_PATH}.desc")

      argument :username,
               String,
               required: true,
               description: I18n.t("#{I18N_PATH}.args.username")

      argument :email,
               String,
               required: true,
               description: I18n.t("#{I18N_PATH}.args.email")

      argument :password,
               String,
               required: true,
               description: I18n.t("#{I18N_PATH}.args.password")

      argument :password_confirmation,
               String,
               required: true,
               description: I18n.t("#{I18N_PATH}.args.password_confirmation")
    end
  end
end
