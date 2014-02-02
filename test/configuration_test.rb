require 'test_helper'

describe "Configuration" do
  describe "#extensions" do
    it "includes 'Exception' by default" do
      assert { CoreExtensions::Configuration.new.extensions.include?("Exception") }
    end

    it "is emptyable" do
      CoreExtensions.configure do |config|
        config.extensions = []
      end
      assert { CoreExtensions.configuration.extensions.empty? }
    end

    it "is customizable" do
      CoreExtensions.configure do |config|
        config.extensions = %w[Hello Goodbye]
      end
      assert { CoreExtensions.configuration.extensions == %w[Hello Goodbye] }
    end
  end
end
