require 'active_support/core_ext/enumerable'
require 'active_support/core_ext/string/inflections'
require 'thor'
require "rspec_snitch/version"
require "rspec_snitch/pending_reporter"
require "rspec_snitch/external_service_adapter"

module RspecSnitch

  def self.new(*args)
    PendingReporter.new(*args)
  end
end
