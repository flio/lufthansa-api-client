module Lufthansa
  class Flight < Resource
    attr_accessor :departure, :arrival, :equipment, :flight_status, :operating_carrier

    @@base_path = '/v1/operations/flightstatus'
    class << self

      # https://api.lufthansa.com/v1/operations/flightstatus/LH13/2018-07-02
      def status(flight_number, date)
        response = API.get("#{@@base_path}/#{flight_number}/#{date}")
        parsed_response = from_response(response, 'FlightStatusResource', 'Flights', 'Flight')
      end

      def departure_from(airport_code:, date_time:, limit: 100, offset: 0)
        response = API.get("#{@@base_path}/departures/#{airport_code}/#{date_time}", { limit: limit, offset: offset })
        parsed_response = from_response(response, 'FlightStatusResource', 'Flights', 'Flight')
      end

      def arriving_at(airport_code:, date_time:, limit: 100, offset: 0)
        response = API.get("#{@@base_path}/arrivals/#{airport_code}/#{date_time}", { limit: limit, offset: offset })
        parsed_response = from_response(response, 'FlightStatusResource', 'Flights', 'Flight')
      end
    end
  end
end