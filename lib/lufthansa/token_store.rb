module Lufthansa
  class TokenStore
    class << self
      attr_accessor :default
    end

    def load
      raise 'Not implemented'
    end

    def save(token)
      raise 'Not implemented'
    end

    def delete
      raise 'Not implemented'
    end

    def auth_token
      "#{@type} #{@token}"
    end
  end
end