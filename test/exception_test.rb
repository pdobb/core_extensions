require 'test_helper'

describe Exception do
  describe "#inspect_backtrace" do
    it "outputs class, message, and application-specific backtrace" do
      begin
        asdf
      rescue => ex
        result = ex.inspect_backtrace
      end

      assert { result.starts_with?("NameError (undefined local variable or method `asdf'") }
      assert { result =~ %r{core_extensions/test/exception_test.rb:\d+:in} }
    end

    it "outputs class, message, and full backtrace given nil backtrace_cleaner" do
      begin
        asdf
      rescue => ex
        result = ex.inspect_backtrace(nil)
      end

      assert { result.starts_with?("NameError (undefined local variable or method `asdf'") }
      assert { result =~ %r{core_extensions/test/exception_test.rb:\d+:in} }
    end
  end
end
