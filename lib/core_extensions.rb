require_relative "core_extensions/configuration"

CoreExtensions.configuration.extensions.each do |method_name|
  require_relative "core_extensions/#{method_name.downcase}"
end
