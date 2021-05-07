# frozen_string_literal: true

FactoryBot.define do
  factory :comment do |f|
    f.title { Faker::Lorem.sentence }
    task
    trait :having_attachment do
      image { Rack::Test::UploadedFile.new('spec/fixtures/files/image.png') }
    end
  end
end
