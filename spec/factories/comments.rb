# frozen_string_literal: true

FactoryBot.define do
  factory :comment do |f|
    f.title { Faker::Lorem.sentence }
    f.task_id { create(:task).id }
  end
end
