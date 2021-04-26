# frozen_string_literal: true

FactoryBot.define do
  factory :task do |f|
    f.title { Faker::Lorem.sentence }
    f.done { Faker::Boolean.boolean(true_ratio: 0.5) }
    f.deadline { Faker::Time.between(from: DateTime.now - 1, to: DateTime.now, format: :short) }
    f.user_id { create(:user).id }
  end
end
