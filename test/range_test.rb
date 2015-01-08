require 'test_helper'

describe Range do
  describe "#time_step" do
    it "steps through time by the specified time interval" do
      start_time = Time.parse("11:00")
      end_time = Time.parse("13:00")
      result = (start_time..end_time).time_step(30.minutes)
                                     .map { |time| time.strftime("%H:%M") }

      result.must_equal(["11:00", "11:30", "12:00", "12:30", "13:00"])
    end
  end
end
