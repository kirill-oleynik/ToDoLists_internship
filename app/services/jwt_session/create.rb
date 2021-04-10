# frozen_string_literal: true

module JwtSession
  # Responsible for creating user session
  class Create
    def initialize(session: JWTSessions::Session)
      @session = session
    end

    def call(user_id:)
      payload = { user_id: user_id }

      session.new(
        payload: payload,
        refresh_payload: payload
      )
    end

    private

    attr_reader :session
  end
end
