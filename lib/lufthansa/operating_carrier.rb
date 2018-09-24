module Lufthansa
  class OperatingCarrier < Resource
    attr_accessor :airline_id, :flight_number

    def full_number
      "#{airline_id} #{flight_number}"
    end
  end
end