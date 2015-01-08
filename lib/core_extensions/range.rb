class Range
  def time_step(step, &block)
    return enum_for(:time_step, step) unless block_given?

    start_time, end_time = first, last
    begin
      yield(start_time)
    end while (start_time += step) <= end_time
  end
end
