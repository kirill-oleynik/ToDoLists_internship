require 'shrine'

Shrine.plugin :activerecord
Shrine.plugin :validation_helpers
Shrine.plugin :determine_mime_type
