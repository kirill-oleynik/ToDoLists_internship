# frozen_string_literal: true

module API::V1::Comments::Contract
  # Task Comment create create and update contract
  class SetAttributes < Dry::Validation::Contract
    params do
      required(:title).filled(:str?)
      optional(:image).maybe(:filled?)
    end

    rule(:image) do
      next unless value

      attacher = ImageUploader::Attacher.new
      attacher.assign(value)
      attacher.errors.map { |error| key.failure(error) }
    rescue JSON::ParserError
      key.failure(:supported_format?)
    end
  end
end
