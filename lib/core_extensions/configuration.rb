module CoreExtensions
  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  class Configuration
    # Which conversion method to require on gem initialization
    attr_reader :extensions

    def initialize
      @extensions = %w[Exception]
    end

    def extensions=(val)
      @extensions = Array(val)
    end
  end

  configure {}
end