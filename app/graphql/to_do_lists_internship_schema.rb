# frozen_string_literal: true

# Application GraphQL Schema
class ToDoListsInternshipSchema < GraphQL::Schema
  mutation(Types::MutationType)
  query(Types::QueryType)
  max_complexity(Constants::GraphQL::SCHEMA_SETTINGS[:MAX_COMPLEXITY])
  max_depth(Constants::GraphQL::SCHEMA_SETTINGS[:MAX_DEPTH])
end
