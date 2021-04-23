# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.1'

# Trailblazer bundle
gem 'bcrypt', '~> 3.1.7'
gem 'graphql', '~> 1.12', '>= 1.12.5'
gem 'jsonapi-serializer', '~> 2.1'
gem 'jwt_sessions', '~> 2.5', '>= 2.5.2'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'rails', '~> 6.1.1'
gem 'redis', '~> 4.2', '>= 4.2.5'
gem 'reform-rails', '~> 0.2.1'
gem 'rubocop-graphql', require: false
# gem 'image_processing', '~> 1.2'
gem 'bootsnap', '>= 1.4.4', require: false
gem 'rack-cors'

gem 'dry-matcher', '~> 0.9'

# Trailblazer bundle
gem 'dry-validation', '~> 1.6'
gem 'simple_endpoint', '~> 1.0'
gem 'trailblazer', '~> 2.1'
gem 'trailblazer-operation', '~> 0.6.6'
group :development, :test do
  gem 'awesome_print', '~> 1.8'
  gem 'bullet', '~> 6.1'
  gem 'factory_bot_rails', '~> 6.1'
  gem 'faker', '~> 2.15', '>= 2.15.1'
  gem 'pry-rails', '~> 0.3.9'
  gem 'rubocop', '~> 1.9', '>= 1.9.1'
  gem 'rubocop-performance', '~> 1.9', '>= 1.9.2'
  gem 'rubocop-rails', '~> 2.9', '>= 2.9.1'
  gem 'sidekiq', '~> 6.2', '>= 6.2.1'
end

group :test do
  gem 'json_matchers', '~> 0.11.1'
  gem 'rspec-rails', '~> 4.0', '>= 4.0.2'
  gem 'rubocop-rspec', '~> 2.1'
  gem 'shoulda-matchers', '~> 4.5', '>= 4.5.1'
end

group :development do
  gem 'listen', '~> 3.3'
  gem 'spring'
end
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
