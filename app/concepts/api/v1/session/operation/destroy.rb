# frozen_string_literal: true

module API
  module V1
    module Session
      module Operation
        # Destroy Session operation
        class Destroy < ApplicationOperation
          step :flush_session
          step :result

          def flush_session(_, payload:, **)
            JWTSessions::Session.new(
              refresh_by_access_allowed: true,
              payload: payload
            ).flush_by_access_payload
          end

          def result(ctx, **)
            ctx[:result] = { success: true }
          end
        end
      end
    end
  end
end
