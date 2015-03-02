require 'active_support/core_ext/enumerable'
require 'active_support/core_ext/string/inflections'
require 'thor'
require "spec_snitch/version"
require "spec_snitch/pending_reporter"
require "spec_snitch/external_service_adapter"

module SpecSnitch

  def self.new(*args)
    PendingReporter.new(*args)
  end

  def self.snitch_to(*args)
    self.new(*args)
  end
end
