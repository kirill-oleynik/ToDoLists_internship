# frozen_string_literal: true

FactoryBot.define do
  factory :user do |f|
    f.username { Faker::Name.unique.name }
    f.email { Faker::Internet.unique.email }
    f.password { Faker::Internet.password }
    f.password_confirmation { password }
  end
end

def create_user_with_tasks(tasks_count: 5)
  FactoryBot.create(:user) do |user|
    FactoryBot.create_list(:task, tasks_count, user_id: user.id)
  end
end
