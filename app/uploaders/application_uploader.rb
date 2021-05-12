# frozen_string_literal: true

# Includes logic & behaviour required by all other uploaders
class ImageUploader < Shrine
  Shrine.plugin :activerecord
end
