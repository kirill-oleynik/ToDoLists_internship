# frozen_string_literal: true

# Describes uploading image validation rules
class ImageUploader < Shrine
  Attacher.validate do
    validate_size      Constants::Uploads::FILE_SIZE_RANGE
    validate_mime_type Constants::Uploads::FILE_MIME_TYPES
    validate_extension Constants::Uploads::FILE_EXTENTIONS
  end
end
