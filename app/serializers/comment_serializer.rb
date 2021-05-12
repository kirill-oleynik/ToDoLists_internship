# frozen_string_literal: true

class CommentSerializer
  include JSONAPI::Serializer

  belongs_to :task, serializer: TaskSerializer

  attributes :id, :title, :image_url
end
