# frozen_string_literal: true

module API
  module V1
    module Accounts
      class SessionsController < AccountsController
        def create
          endpoint operation: API::V1::Auth::Operation::SignIn
        end
      end
    end
  end
end
