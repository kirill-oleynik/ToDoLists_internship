# frozen_string_literal: true

require 'trailblazer/operation'

class ApplicationOperation < Trailblazer::Operation
  private

  def parameter_from(context, key)
    context[:params][key]
  end
end
