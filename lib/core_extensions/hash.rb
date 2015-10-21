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

  # Deep merge the passed in hash while combining the strings found in the
  # :class keys.
  #
  # Example:
  #   h1 = { a: 1, input_html: { class: "c1", b: 1 } }
  #   h2 = { a: 2, input_html: { class: "c2", c: 2 } }
  #   h1.deep_merge_combining_css_classes(h2)
  #   # => { a: 2, input_html: { class: "c1 c2", b: 1, c: 2 } }
  def deep_merge_combining_css_classes(new_hash = {})
    return self if new_hash.blank?

    deep_merge(new_hash) { |key, current_value, new_value|
      if key.to_sym == :class
        [current_value, new_value].join(' ').strip
      else
        new_value
      end
    }
  end

  # This version modifies the original hash.
  # @see {#deep_merge_combining_css_classes}
  def deep_merge_combining_css_classes!(new_hash = {})
    return self if new_hash.blank?

    deep_merge!(new_hash) { |key, current_value, new_value|
      if key.to_sym == :class
        [current_value, new_value].join(' ').strip
      else
        new_value
      end
    }
  end
end
