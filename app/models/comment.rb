# frozen_string_literal: true

# Task Comment entity
class Comment < ApplicationRecord
  include ImageUploader::Attachment(:image)
  belongs_to :task
end
