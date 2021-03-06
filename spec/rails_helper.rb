# frozen_string_literal: true

require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../config/environment', __dir__)
abort('The Rails environment is running in production mode!') if Rails.env.production?
require 'rspec/rails'
require 'faker'
require 'pry'
require 'factory_bot'
require 'json_matchers/rspec'
JsonMatchers.schema_root = 'spec/support/api/schemas'
Dir[Rails.root.join('spec', 'support', '**', '*.rb')].sort.each { |f| require f }

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end
ActiveRecord::Migration.check_pending!
RSpec.configure do |config|
  config.include Requests::JsonHelpers, type: :request
  config.include Requests::AuthHelpers, type: :request
  config.include Requests::AuthHelpers, type: :operation
  config.include Requests::AuthHelpers, type: :service
  config.include GraphQL::RequestHelpers, type: :request
  config.include GraphQL::MutationHelpers, type: :request
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
end
