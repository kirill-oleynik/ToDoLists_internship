# frozen_string_literal: true

module JwtSession
  # Unpacks token coded by JwtSession::Create and returns user_id from payload
  class GetUserIdFromToken
    def initialize(token)
      @token = token
    end

    def call
      JWTSessions::Token.decode(token)[0]['user_id']
    end

    private

    attr_reader :token
  end
end
