require_relative "core_extensions/configuration"
require_relative "prefixes_helper"

CoreExtensions.configuration.extensions.each do |method_name|
  require_relative "core_extensions/#{method_name.downcase}"
end
