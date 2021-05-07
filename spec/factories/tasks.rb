# frozen_string_literal: true

FactoryBot.define do
  factory :task do |f|
    f.title { Faker::Lorem.sentence }
    f.done { Faker::Boolean.boolean(true_ratio: 0.5) }
    f.deadline { (Date.today + rand(100)).to_s }
    user
  end
end

def create_task_with_comments(comments_count: 5)
  FactoryBot.create(:task) do |task|
    FactoryBot.create_list(:comment, comments_count, task_id: task.id)
  end
end
