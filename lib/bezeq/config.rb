require 'active_support/configurable'

module Bezeq
  class Config
    include ::ActiveSupport::Configurable

    config_accessor :account, :user, :pass, :from, :dlr_url, :override_source, :end_point

    def initialize(options = {})
      options.each do |key, value|
        config.send("#{key}=", value)
      end
    end
  end
end
