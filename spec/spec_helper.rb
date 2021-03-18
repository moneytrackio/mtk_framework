# frozen_string_literal: true

require 'bundler/setup'

require_relative '../lib/mtk_framework.rb'
require 'faker'

require_relative 'fake_app.rb'

# require shared files
require_relative 'gem_extensions/active_interaction/filters_shared.rb'
require_relative 'gem_extensions/active_interaction/tz_filters_shared.rb'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  # config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  # config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
