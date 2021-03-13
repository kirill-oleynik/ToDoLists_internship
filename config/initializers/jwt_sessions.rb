# frozen_string_literal: true

EXPIRATION = {
  access: 3_600, # 1 hour
  refresh: 86_400 # 24 hours
}.freeze

JWTSessions.algorithm = 'HS256'
JWTSessions.private_key = OpenSSL::PKey::RSA.generate(2048)
JWTSessions.public_key  = JWTSessions.private_key.public_key
JWTSessions.access_exp_time = EXPIRATION[:access]
JWTSessions.refresh_exp_time = EXPIRATION[:refresh]
JWTSessions.token_store = :memory
