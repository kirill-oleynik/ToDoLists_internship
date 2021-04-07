# frozen_string_literal: true

# frozen_string_literal: true

module GraphQL
  # handles app 403 Forbidden Error
  class ForbiddenError < ExecutionError
    def to_h
      super.merge('extensions' => { 'code' => 'UNAUTHORIZED' })
    end
  end
end
