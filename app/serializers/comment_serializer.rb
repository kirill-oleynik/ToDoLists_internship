# frozen_string_literal: true

class CommentSerializer
  include JSONAPI::Serializer
  attributes :id,
             :title
  belongs_to :task
  attribute :image do |comment|
    comment.image&.url
  end
end
