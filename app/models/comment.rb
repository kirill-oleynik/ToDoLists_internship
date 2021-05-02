# frozen_string_literal: true

# Task Comment entity
class Comment < ApplicationRecord
  belongs_to :task
end
