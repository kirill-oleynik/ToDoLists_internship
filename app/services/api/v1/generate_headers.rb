# frozen_string_literal: true

module API
  module V1
    # Generates response header with auth token
    class GenerateHeaders < ApplicationService
      def call(user:)
        { JWTSessions.access_header => "Bearer #{access_token(user)}" }
      end

      private

      def access_token(user)
        JWTSessions::Session.new(payload: payload(user), refresh_by_access_allowed: true).login[:access]
      end

      def payload(user)
        { user_id: user.id }
      end
    end
  end
end
