require 'bezeq/config'
require 'bezeq/sender'
require 'bezeq/version'

module Bezeq
  class Error < StandardError; end

  def self.configuration
    @configuration ||= Config.new
  end

  def self.config
    config = configuration
    yield(config)
  end
end
