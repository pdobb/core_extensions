require 'test_helper'

describe "Configuration" do
  describe "#extensions" do
    it "includes 'Exception' by default" do
      CoreExtensions::Configuration.new.extensions.must_include "Exception"
    end

    it "is emptyable" do
      CoreExtensions.configure do |config|
        config.extensions = []
      end
      CoreExtensions.configuration.extensions.must_be_empty
    end

    it "is customizable" do
      CoreExtensions.configure do |config|
        config.extensions = %w[Hello Goodbye]
      end
      CoreExtensions.configuration.extensions.must_equal %w[Hello Goodbye]
    end
  end
end
