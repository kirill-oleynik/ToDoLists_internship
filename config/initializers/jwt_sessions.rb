# frozen_string_literal: true

JWTSessions.token_store = :redis, {
  redis_host: Rails.application.credentials.redis[:host],
  redis_port: Rails.application.credentials.redis[:port],
  redis_db_name: Rails.application.credentials.redis[:db_name],
  token_prefix:  Rails.application.credentials.redis[:token_prefix]
}
JWTSessions.algorithm = 'HS256'
JWTSessions.encryption_key = Rails.application.credentials.secret_key_base
JWTSessions.access_exp_time = 1.hour
JWTSessions.refresh_exp_time = 24.hours

JWTSessions.access_header  = "Authorization"
JWTSessions.refresh_header = "X-Refresh-Token"
