# frozen_string_literal: true

# Error Serializer
class ErrorSerializer
  def initialize(contract)
    @contract = contract
  end

  def serialized_json
    error_fields = @contract.errors.messages.map do |field, errors|
      errors.map do |error_message|
        {
          source: { pointer: "/data/attributes/#{field}" },
          detail: error_message
        }
      end
    end.flatten

    { errors: error_fields }
  end
end
