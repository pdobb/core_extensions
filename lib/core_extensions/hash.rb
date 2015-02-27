class Hash
  # Execute the block setting the given values and restoring old values after
  # the block is executed.
  def swap(new_values)
    old_values = {}
    new_values.each do |key, value|
      old_values[key] = send(:[], key)
      send(:store, key, value)
    end
    yield
  ensure
    old_values.each do |key, value|
      send(:store, key, value)
    end
  end
end
