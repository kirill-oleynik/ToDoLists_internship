# frozen_string_literal: true

module API
  module V1
    module Accounts
      class RegistrationsController < AccountsController
        def create
          endpoint operation: API::V1::Auth::Operation::SignUp
        end
      end
    end
  end
end
