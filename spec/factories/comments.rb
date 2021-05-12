# frozen_string_literal: true

FactoryBot.define do
  factory :comment do |f|
    f.title { Faker::Lorem.sentence }
    task
    trait :with_valid_attachment do
      image { Rack::Test::UploadedFile.new('spec/fixtures/files/image.png') }
    end
    trait :with_invalid_attachment do
      image { Rack::Test::UploadedFile.new('spec/fixtures/files/not_an_image.pdf') }
    end
  end
end
