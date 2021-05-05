require 'shrine'
require 'shrine/storage/file_system'
require 'shrine/storage/s3'
require 'shrine/storage/memory'

case Rails.env
when 'production'
  s3_options = {
    bucket: Rails.application.credentials.aws[:bucket],
    region: Rails.application.credentials.aws[:region],
    access_key_id: Rails.application.credentials.aws[:access_key_id],
    secret_access_key: Rails.application.credentials.aws[:secret_access_key],
  }
  Shrine.storages = {
    cache: Shrine::Storage::S3.new(prefix: 'cache', **s3_options),
    store: Shrine::Storage::S3.new(**s3_options),
  }
when 'development'
  Shrine.storages = {
    cache: Shrine::Storage::FileSystem.new('storage', prefix: 'uploads/cache'),
    store: Shrine::Storage::FileSystem.new('storage', prefix: 'uploads'),
  }
when 'test'
  Shrine.storages = {
    cache: Shrine::Storage::Memory.new,
    store: Shrine::Storage::Memory.new
  }
end

Shrine.plugin :activerecord
Shrine.plugin :cached_attachment_data
Shrine.plugin :restore_cached_data
Shrine.plugin :validation_helpers
Shrine.plugin :determine_mime_type
