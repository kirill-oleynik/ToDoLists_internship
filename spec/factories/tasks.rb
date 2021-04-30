# frozen_string_literal: true

require 'date'

FactoryBot.define do
  factory :task do |f|
    f.title { Faker::Lorem.sentence }
    f.done { Faker::Boolean.boolean(true_ratio: 0.5) }
    f.deadline { (Date.today + rand(100)).to_s }
    f.user_id { create(:user).id }
  end
end
