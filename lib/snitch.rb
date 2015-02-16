require 'active_support/core_ext/enumerable'
require 'active_support/core_ext/string/inflections'
require 'thor'
require "snitch/version"
require "snitch/pending_reporter"
require "snitch/external_service_adapter"

module Snitch

  def self.new(*args)
    PendingReporter.new(*args)
  end

  def self.snitch_to(*args)
    self.new(*args)
  end
end
