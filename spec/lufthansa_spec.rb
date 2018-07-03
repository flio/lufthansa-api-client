RSpec.describe Lufthansa do
  it "has a version number" do
    expect(Lufthansa::VERSION).not_to be nil
  end

  describe 'settings' do
    it 'raise an exception if client_id is not set' do
      Lufthansa.client_id = nil
      expect{ Lufthansa.client_id }.to raise_error(Lufthansa::ConfigurationError)
    end
    
    it 'raise an exception if client_secret is not set' do
      Lufthansa.client_secret = nil
      expect{ Lufthansa.client_secret }.to raise_error(Lufthansa::ConfigurationError)
    end

    it 'raise an exception if api_id is not set' do
      Lufthansa.api_id = nil
      expect{ Lufthansa.api_id }.to raise_error(Lufthansa::ConfigurationError)
    end
  end
end
