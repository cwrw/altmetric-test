require "spec_helper"

RSpec.describe Combine::Record do
  describe "#valid?" do
    it "is valid if all fields are populated" do
      subject = described_class.new(
        doi: "doi",
        title: "title",
        author: "author",
        journal: "journal",
        issn: "issn"
      )
      expect(subject).to be_valid
    end

    it "returns invalid otherwise" do
      subject = described_class.new(
        doi: "doi",
        title: "title",
        author: "author",
        journal: "journal",
        issn: nil
      )
      expect(subject).to_not be_valid
    end
  end
end
