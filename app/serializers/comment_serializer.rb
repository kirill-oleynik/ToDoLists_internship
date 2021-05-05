# frozen_string_literal: true

class CommentSerializer
  include JSONAPI::Serializer
  attributes :id,
             :title
  belongs_to :task
end
