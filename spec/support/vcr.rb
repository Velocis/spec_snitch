require 'vcr'
require 'webmock/rspec'

WebMock.disable_net_connect!(allow_localhost: true, allow: 'codeclimate.com')

VCR.configure do |c|
  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :webmock
  c.configure_rspec_metadata!
  c.preserve_exact_body_bytes { true }
end
