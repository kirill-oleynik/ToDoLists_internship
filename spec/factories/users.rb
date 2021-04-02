# frozen_string_literal: true

FactoryBot.define do
  factory :user do |f|
    f.username { Faker::Name.unique.name }
    f.email { Faker::Internet.unique.email }
    f.password { Faker::Internet.password }
    # f.password_confirmation { password }
  end
end
