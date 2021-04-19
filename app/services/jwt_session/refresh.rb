# frozen_string_literal: true

module JwtSession
  # Responsible for refreshing user session
  class Refresh
    def initialize(session: JWTSessions::Session.new)
      @session = session
    end

    def call(refresh_token)
      session.refresh(refresh_token)
    end

    private

    attr_reader :session
  end
end
