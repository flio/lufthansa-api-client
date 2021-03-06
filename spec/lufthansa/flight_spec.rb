require 'spec_helper'

RSpec.describe Lufthansa::Flight do

  describe 'status' do

    context 'single flight' do
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

      it 'returns estimated time for future flight' do
        VCR.use_cassette('ew2045_2018-07-06') do
          flight = Lufthansa::Flight.status('EW2045', "2018-07-06")
          expect(flight.departure).not_to eq nil
          expect(flight.arrival).not_to eq nil
          
          dep_status = flight.departure.time_status
          expect(dep_status.definition).to eq 'Flight Delayed'
          expect(flight.departure.estimated_time_local).not_to eq nil

          dep_terminal = flight.departure.terminal
          expect(dep_terminal.name).to eq 2
          expect(dep_terminal.gate).to eq 'A46'
          
          equipment = flight.equipment
          expect(equipment.aircraft_code).to eq '31D'
        end
      end

      it 'returns actual time for sent flight' do
        VCR.use_cassette('ew7464_2018-07-06') do
          flight = Lufthansa::Flight.status('EW7464', "2018-07-06")
          expect(flight.departure).not_to eq nil
          expect(flight.arrival).not_to eq nil
          
          dep_status = flight.departure.time_status
          expect(dep_status.definition).to eq 'Flight Delayed'
          expect(flight.departure.actual_time_local).not_to eq nil

          dep_terminal = flight.departure.terminal
          expect(dep_terminal.name).to eq 2
          expect(dep_terminal.gate).to eq 'B47'
          
          equipment = flight.equipment
          expect(equipment.aircraft_code).to eq '31B'
        end
      end

      context 'all flights departure from airport' do
        it 'return array of flights' do
          VCR.use_cassette('FRA_departure_flights') do
            flights = Lufthansa::Flight.departure_from(airport_code: 'FRA', date_time: '2018-09-24T09:00')
            flights.is_a? Array
          end
        end
      end
      context 'all flights arriving at airport' do
        it 'return array of flights' do
          VCR.use_cassette('FRA_arriving_flights') do
            flights = Lufthansa::Flight.arriving_at(airport_code: 'FRA', date_time: '2018-09-24T09:00')
            flights.is_a? Array
          end
        end
      end
    end
  end
end