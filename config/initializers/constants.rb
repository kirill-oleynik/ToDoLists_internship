module Constants
  module User
    PASSWORD_MIN_SIZE = 6
    EMAIL_REGEXP = /.+@.+\..+/.freeze
  end
  module GraphQL
    SCHEMA_SETTINGS = {
    MAX_COMPLEXITY: 100,
    MAX_DEPTH: 10
  }.freeze
  end
end
