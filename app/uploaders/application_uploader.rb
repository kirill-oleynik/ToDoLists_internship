# frozen_string_literal: true

# Includes logic & behaviour required by all other uploaders
class ImageUploader < Shrine
  Shrine.plugin :activerecord
  Shrine.plugin :validation_helpers
  Shrine.plugin :determine_mime_type
end
