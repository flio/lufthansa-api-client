require 'yaml/store'

module Lufthansa
  module Stores
    class FileStore < TokenStore
      KEY_VALUE = 'token'
      KEY_TYPE = 'token-type'
      KEY_EXPIRES_IN = 'expires_in'
      KEY_LAST_UPDATE_AT = 'last_update_at'

      attr_reader :token, :last_update_at, :expires_in

      # Create a new store with the supplied file.
      #
      # @param [String, File] file
      #  Path to storage file
      def initialize(options = {})
        path = options[:file]
        @store = YAML::Store.new(path)
      end

      def read
        @token = @store.transaction { @store[KEY_VALUE] }
        @type = @store.transaction { @store[KEY_TYPE] }
        @expires_in = @store.transaction { @store[KEY_EXPIRES_IN] }
        @last_update_at = @store.transaction { @store[KEY_LAST_UPDATE_AT] }
      end

      # {"access_token"=>"2qsf98j3heyc5gpgfpbdsbwp", "token_type"=>"bearer", "expires_in"=>129600} 
      def save(token)
        @store.transaction do
          @store[KEY_VALUE] = token['access_token']
          @store[KEY_TYPE] = token['token_type'].capitalize
          @store[KEY_EXPIRES_IN] = token['expires_in']
          @store[KEY_LAST_UPDATE_AT] = Time.now.to_i
        end
      end

      def delete
        raise 'Not implemented'
      end

      def token_valid?
        return false unless token
        (last_update_at + expires_in) > Time.now.to_i
      end
    end 
  end
end