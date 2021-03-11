# frozen_string_literal: true

# Application GraphQL Schema
class ToDoListsInternshipSchema < GraphQL::Schema
  mutation(Types::MutationType)
  query(Types::QueryType)
  max_complexity(Constants::GraphQL::SHEMA_SETTINGS[:MAX_COMPLEXITY])
  max_depth(Constants::GraphQL::SHEMA_SETTINGS[:MAX_DEPTH])
end
