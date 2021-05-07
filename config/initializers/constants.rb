module Constants
  module User
    PASSWORD_MIN_SIZE = 6
    EMAIL_REGEXP = /.+@.+\..+/.freeze
  end
  module GraphQL
    RESPONSE_STATUSES = {
      status422: 'EXECUTION_ERROR'
    }
    SCHEMA_SETTINGS = {
    MAX_COMPLEXITY: 100,
    MAX_DEPTH: 10
  }.freeze
  end
  module Uploads
    FILE_SIZE_RANGE = (1..10.megabytes).freeze
    FILE_MIME_TYPES = %w[image/jpeg image/png].freeze
    FILE_EXTENTIONS = %w[jpg jpeg png].freeze
  end
end
