require 'spec_helper'

RSpec.describe Lufthansa::Flight do

  describe 'status' do
    it 'by flight number and date' do
      VCR.use_cassette('lh17_2018-07-03') do
        flight = Lufthansa::Flight.status('LH17', "2018-07-03")
        expect(flight.departure).not_to eq nil
        expect(flight.arrival).not_to eq nil
        
        dep_status = flight.departure.time_status
        expect(dep_status.definition).to eq 'Flight On Time'

        dep_terminal = flight.departure.terminal
        expect(dep_terminal.name).to eq 2
        expect(dep_terminal.gate).to eq 'C15'
        
        equipment = flight.equipment
        expect(equipment.aircraft_code).to eq 321
      end
    end
  end
end