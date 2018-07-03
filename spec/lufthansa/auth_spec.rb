require 'spec_helper'

RSpec.describe Lufthansa::Auth do

  describe 'get token' do
    it 'successful when settings are correct' do
      VCR.use_cassette('token_success') do
        token = Lufthansa::Auth.new.get_token
        expect(token).to include('Bearer')
      end
    end
  end
end