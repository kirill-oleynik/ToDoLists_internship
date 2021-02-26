JWTSessions.algorithm = "HS256"
JWTSessions.encryption_key = Rails.application.secrets.secret_jwt_encryption_key
JWTSessions.token_store = :memory
