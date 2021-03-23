# frozen_string_literal: true

module Types
  module Inputs
    module Auth
      # User Sign up input type
      class SignUp < ::Types::Base::InputObject
        I18N_PATH = 'graphql.inputs.sign_up'
        graphql_name 'SignUp'

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
end
