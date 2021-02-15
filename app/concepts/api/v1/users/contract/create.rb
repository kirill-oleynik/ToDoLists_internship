# frozen_string_literal: true

module API
  module V1
    module Users
      module Contract
        # Create User entity operation parameters validation
        class Create < ApplicationContract
          EMAIL_REGEXP = /.+@.+\..+/.freeze
          property :username
          property :email

          validation do
            params do
              required(:username).filled(:string)
              required(:email).filled(:string, format?: EMAIL_REGEXP)
            end
          end
        end
      end
    end
  end
end
