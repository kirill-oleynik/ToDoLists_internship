# frozen_string_literal: true

# Responsible for building jwt user session
class JwtSessionBuilder
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
