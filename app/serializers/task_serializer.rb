# frozen_string_literal: true

class TaskSerializer
  include JSONAPI::Serializer
  attributes :id,
             :user_id,
             :title,
             :done,
             :deadline
  has_many :comments, serializer: CommentSerializer
end
