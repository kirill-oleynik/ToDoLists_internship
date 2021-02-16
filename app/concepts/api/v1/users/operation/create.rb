# frozen_string_literal: true

require 'trailblazer/operation'

module API
  module V1
    module Users
      module Operation
        class Create < ApplicationOperation
          step Model(User, :new)
          step Contract::Build(Constant: API::V1::Users::Contract::Create)
          step Contract::Validate()
          step Contract::Persist()
        end
      end
    end
  end
end
