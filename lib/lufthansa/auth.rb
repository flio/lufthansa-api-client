require 'json'

module Lufthansa
  class Auth
    attr_reader :store
    # HEADER = {'Content-Type' => 'application/x-www-form-urlencoded'}.freeze 

    def initialize
      @store = Lufthansa.store
      @store.read
    end

    def get_token(force_update: false)
      return store.auth_token if store.token_valid? && !force_update
      data = request_token
      store.save(data)
      store.auth_token
    end

    private

    def request_token
      body = {
        apiId: Lufthansa.api_id,
        grant_type: 'client_credentials',
        client_secret: Lufthansa.client_secret,
        client_id: Lufthansa.client_id
      }
      response = API.authorization('/v1/oauth/token', body)
      JSON.parse(response) if response
    end
  end
end