# frozen_string_literal: true

# Application GraphQL Schema
class ToDoListsInternshipSchema < GraphQL::Schema
  SHEMA_SETTINGS = {
    MAX_COMPLEXITY: 100,
    MAX_DEPTH: 10
  }.freeze
  mutation(Types::MutationType)
  query(Types::QueryType)
  max_complexity(SHEMA_SETTINGS[:MAX_COMPLEXITY])
  max_depth(SHEMA_SETTINGS[:MAX_DEPTH])
end
