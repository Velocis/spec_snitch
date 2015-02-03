require 'aruba/api'
require 'aruba/reporting'
require 'aruba/in_process'

RSpec.configure do |config|
  config.include Aruba::Api

  config.before(:each) do
    restore_env
    clean_current_dir
  end
end
