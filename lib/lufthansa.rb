
module Lufthansa
  class Error < StandardError
    def set_message message
      @message = message
    end

    # @return [String]
    def to_s
      defined? @message and @message or super
    end
  end

  class ConfigurationError < Error
  end

  class RequireParamError < Error; end

  
  class << self
    attr_accessor :logger

    # Convenience logging method includes a Logger#progname dynamically.
    # @return [true, nil]
    def log level, message
      logger.send(level, name) { message }
    end

    def base_url
      @base_url || 'https://api.lufthansa.com'
    end
    attr_writer :base_url

    def client_id
      defined? @client_id and @client_id or raise(
        ConfigurationError, "Lufthansa.client_id not configured"
      )
    end
    attr_writer :client_id

    def client_secret
      defined? @client_secret and @client_secret or raise(
        ConfigurationError, "Lufthansa.app_secret not configured"
      )
    end
    attr_writer :client_secret

    def api_id
      defined? @api_id and @api_id or raise(
        ConfigurationError, "Lufthansa.api_id not configured"
      )
    end
    attr_writer :api_id

    def store
      return @store if defined? @store
       Lufthansa::Stores::FileStore.new(file: 'tokens.yml')
    end
    attr_writer :store

    def timeout
      @timeout || 5
    end
    attr_writer :timeout
  end
  
  require 'lufthansa/version'
  require 'lufthansa/api'
  require 'lufthansa/api/net_http_adapter'
  require 'lufthansa/api/errors'


  require 'lufthansa/helper'
  require 'lufthansa/auth'
  require 'lufthansa/token_store'
  require 'lufthansa/stores/file_store'
  require 'lufthansa/resource'
  require 'lufthansa/flight_part'
  require 'lufthansa/flight'
  require 'lufthansa/flight_status'
  require 'lufthansa/equipment'
  require 'lufthansa/terminal'
  require 'lufthansa/operating_carrier'

  CUSTOM_MODELS = {
    'Departure' => Lufthansa::FlightPart,
    'Arrival' => Lufthansa::FlightPart,
    'TimeStatus' => Lufthansa::FlightStatus,
    'FlightStatus' => Lufthansa::FlightStatus,
    'OperatingCarrier' => Lufthansa::OperatingCarrier
  }.freeze

end

