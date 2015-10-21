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

  describe "#deep_merge_combining_css_classes" do
    subject {
      { a: 1, input_html: { class: "c1", b: 1, c: 1 } }
    }

    let(:new_hash) {
      { a: 2, input_html: { class: "c2", c: 2, d: 2 } }
    }

    let(:combined_hash) {
      { a: 2, input_html: { class: "c1 c2", b: 1, c: 2, d: 2 } }
    }

    it "combines :class strings" do
      subject.deep_merge_combining_css_classes(new_hash)
             .must_equal(combined_hash)
    end

    it "otherwise just acts like a regular deep_merge" do
      new_hash2 = { a: 2, input_html: { b: 2, c: 2 } }
      subject.deep_merge_combining_css_classes(new_hash2)
             .must_equal(subject.deep_merge(new_hash2))
    end

    describe "#deep_merge_combining_css_classes!" do
      it "modifies the original hash" do
        subject.deep_merge_combining_css_classes!(new_hash)
        subject.must_equal combined_hash
      end
    end
  end
end
