require 'simplecov'
SimpleCov.start
require 'rspec_snitch'
require 'vcr'
require 'webmock/rspec'

Dir[File.join(".", "spec/support/**/*.rb")].each { |f| require f }

WebMock.disable_net_connect!(allow_localhost: true, allow: 'codeclimate.com')

VCR.configure do |c|
  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :webmock
  c.configure_rspec_metadata!
  c.preserve_exact_body_bytes { true }
end

RSpec.configure do |config|
  config.backtrace_exclusion_patterns = [
    /\/lib\d*\/ruby\//,
    /bin\//,
    /gems/,
    /spec\/spec_helper\.rb/,
    /lib\/rspec\/(core|expectations|matchers|mocks)/
  ]

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
end
