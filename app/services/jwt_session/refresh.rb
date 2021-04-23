# frozen_string_literal: true

module JwtSession
  # Responsible for refreshing user session
  class Refresh
    def initialize(session_class: JWTSessions::Session, payload: {})
      @payload = payload
      @session = session_class.new(payload)
    end

    def call(refresh_token)
      session.refresh(refresh_token)
    end

    private

    attr_reader :session
  end
end
