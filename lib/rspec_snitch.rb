require "rspec_snitch/version"
require "rspec_snitch/reporter"

module RspecSnitch

  def self.new(*args)
    Reporter.new(*args)
  end
end
