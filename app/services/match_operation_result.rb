# frozen_string_literal: true

# Match Trailblazer operation result service
class MatchOperationResult
  OperationMatcher = Dry::Matcher.new(
    success: Dry::Matcher::Case.new(
      match: ->(result) { result.success? },
      resolve: ->(result) { result['result'] }
    ),
    unprocessable_entity: Dry::Matcher::Case.new(
      match: ->(result) { result.failure? && result['operation_status'] == :unprocessable_entity },
      resolve: ->(result) { result }
    ),
    not_found: Dry::Matcher::Case.new(
      match: lambda do |result|
        result.failure? && (
          (result['result.model'] && result['result.model'].failure?) ||
            result['operation_status'] == :not_found
        )
      end,
      resolve: ->(result) { result }
    ),
    credentials_error: Dry::Matcher::Case.new(
      match: ->(result) { result.failure? && result['operation_status'] == :credentials_error },
      resolve: ->(result) { result }
    ),
    not_authorized: Dry::Matcher::Case.new(
      match: lambda do |result|
        (result['result.policy.default'] && result['result.policy.default'].failure?) ||
          result['operation_status'] == :not_authorized
      end,
      resolve: ->(result) { result }
    ),
    execution_error: Dry::Matcher::Case.new(
      match: ->(result) { result.failure? && result['operation_status'] == :execution_error },
      resolve: ->(result) { result }
    ),
    bad_request: Dry::Matcher::Case.new(
      match: ->(result) { result.failure? && result['operation_status'] == :bad_request },
      resolve: ->(result) { result }
    )
  )
  #
  # Service parameters
  # - operation_result: trailblazer operation after call
  # - context: graphql mutation context
  #
  # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
  def call(operation_result:, **)
    OperationMatcher.call(operation_result) do |m|
      m.success { |result| result }

      m.not_found do |result|
        raise GraphQL::RuntimeError, result['operation_message'] || 'lol'
      end

      m.not_authorized do
        raise GraphQL::ForbiddenError, 'lol'
      end

      m.unprocessable_entity do |result|
        raise GraphQL::RuntimeError, result['contract.default'].errors
      end

      m.credentials_error do |result|
        raise GraphQL::AuthenticationError, contract_base_error(result)
      end

      m.execution_error do |result|
        raise GraphQL::RuntimeError, result['operation_message'] || contract_base_error(result)
      end

      m.bad_request do |result|
        raise GraphQL::RuntimeError, result['operation_message'] || contract_base_error(result)
      end
    end
  end

  private

  def contract_base_error(result)
    result['contract.default'].errors[:base].join(' ')
  end
  # rubocop:enable Metrics/MethodLength, Metrics/AbcSize
end
