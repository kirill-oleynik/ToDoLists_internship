# frozen_string_literal: true

JWTSessions.token_store = :redis, {
  redis_host: ENV['REDIS_HOST'],
  redis_port: ENV['REDIS_PORT'],
  redis_db_name: ENV['REDIS_DB_NAME'],
  token_prefix: ENV['TOKEN_PERFIX']
}
JWTSessions.algorithm = 'HS256'
JWTSessions.encryption_key = ENV['JWTSESSIONS_ENCRYPTION_KEY']
JWTSessions.access_exp_time = 1.hour
JWTSessions.refresh_exp_time = 24.hours
