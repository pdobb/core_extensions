require 'test_helper'

describe Hash do
  subject { { a: "OLD" } }

  describe "#swap" do
    it "uses the supplied values inside the block" do
      subject.swap(a: "NEW") do
        subject[:a].must_equal "NEW"
      end
    end

    it "restores the old values after the block" do
      subject.swap(a: "NEW") {}
      subject[:a].must_equal "OLD"
    end

    it "only temporarily sets unknown keys" do
      subject.swap(b: "UNKNOWN") do
        subject[:b].wont_be_nil
      end
      subject[:b].must_be_nil
    end
  end
end
