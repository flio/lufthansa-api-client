module Lufthansa
  class FlightPart < Resource
    attr_accessor :airport_code,
                  :scheduled_time_local,
                  :scheduled_time_utc,
                  :actual_time_local,
                  :actual_time_utc,
                  :estimated_time_local,
                  :estimated_time_utc,
                  :time_status,
                  :terminal

    def scheduled_time_local
      @scheduled_time_local['DateTime']
    end
    
    def scheduled_time_utc
      @scheduled_time_utc['DateTime']
    end

    def actual_time_local
      return nil unless @actual_time_local.is_a?(Hash)
      @actual_time_local['DateTime']
    end

    def actual_time_utc
      return nil unless @actual_time_utc.is_a?(Hash)
      @actual_time_utc['DateTime']
    end

    def estimated_time_local
      return nil unless @estimated_time_local.is_a?(Hash)
      @estimated_time_local['DateTime']
    end

    def estimated_time_utc
      return nil unless @estimated_time_utc.is_a?(Hash)
      @estimated_time_utc['DateTime']
    end
  end
end