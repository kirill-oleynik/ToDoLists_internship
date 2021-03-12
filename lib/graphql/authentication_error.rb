# frozen_string_literal: true

module GraphQL
  # handles app 401 AUTH Error
  class AuthenticationError < ExecutionError
    def to_h
      super.merge('extensions' => { 'code' => 'UNAUTHENTICATED' })
    end
  end
end
