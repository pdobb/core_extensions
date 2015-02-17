# Helper methods for adding ActionView::LookupContext prefixes on including
# controllers. The lookup_context.prefixes collection is persisted on cached
# controllers, so these helpers take care to remove the passed-in prefixes
# after calling the block.
#
# @example Expected Usage:
#   around_action only: :show do |_, block|
#     prepend_lookup_context_prefixes("my_optional_name_space/my_objects", &block)
#   end
#
#   around_action only: %i[index edit update] do |_, block|
#     append_penultimate_lookup_context_prefixes("my_optional_name_space/my_objects", &block)
#   end
module PrefixesHelper
  # Prepends the passed in prefixes to the current `lookup_context.prefixes`
  # array, calls the block, then removes the prefixes.
  #
  # @param [Array<String>] prefixes
  def prepend_lookup_context_prefixes(*prefixes, &block)
    lookup_context.prefixes.prepend(*prefixes)
    block.call
    remove_lookup_context_prefixes(*prefixes, index: 0)
  end

  # Sets the penultimate (2nd-to-last) prefixes in the current
  # `lookup_context.prefixes` array, calls the block, then removes the prefixes.
  #
  # @param [Array<String>] prefixes
  def append_penultimate_lookup_context_prefixes(*prefixes, &block)
    lookup_context.prefixes.insert(-2, *prefixes)
    block.call
    remove_lookup_context_prefixes(*prefixes.reverse, index: -2)
  end

  # Removes the passed in prefixes from the current `lookup_context.prefixes`
  # array. If index is passed in, then will only remove prefixes found at the
  # specified index in the array.
  #
  # @param [Array<String>] prefixes
  # @param [Integer] index
  def remove_lookup_context_prefixes(*prefixes, index: nil)
    prefixes.each do |prefix|
      if index
        if lookup_context.prefixes[index] == prefix
          lookup_context.prefixes.delete_at(index)
        end
      else
        lookup_context.prefixes.delete(prefix)
      end
    end
  end
end
