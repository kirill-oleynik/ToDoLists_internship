# frozen_string_literal: true

module JwtSession
  # Responsible for creating user session
  class Destroy
    def initialize(session: JWTSessions::Session)
      @session = session
    end

    def call(refresh_token)
      session.new.flush_by_token(refresh_token)
    end

    private

    attr_reader :session
  end
end
