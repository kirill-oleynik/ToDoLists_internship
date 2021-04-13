# frozen_string_literal: true

module API::V1::Auth::Operation
  # SignUp User operation
  class SignIn < ApplicationOperation
    step Contract::Build(constant: API::V1::Auth::Contract::SignIn)
    step Contract::Validate()
    step :create_session

    def create_session(context, **)
      username, password = %i[username password].map { |key| parameter_from(context, key) }
      user = User.find_by(username: username).authenticate(password)
      JwtSession::Create.new.call(user_id: user.id).login
    end

    private

    def parameter_from(context, key)
      context[:params][key]
    end
  end
end
