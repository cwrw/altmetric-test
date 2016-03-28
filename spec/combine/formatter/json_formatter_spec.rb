require "spec_helper"

RSpec.describe Formatter::JSONFormatter do
  include_context "file data setup"
  describe "#read_from" do
    it "reads json file" do
      expect { described_class.read_from(authors_file) }.to_not raise_error
    end
  end

  describe "#write" do
    let(:records) do
      [
        Combine::Record.new(
          doi: "doi",
          title: "title",
          author: "author",
          journal: "journal",
          issn: "issn"
        )
      ]
    end

    let(:formatted_records) do
      [
        {
          "doi" => "doi",
          "title" => "title",
          "author" => "author",
          "journal" => "journal",
          "issn" => "issn"
        }
      ].to_json
    end

    it "transforms objects to json format" do
      expect(described_class.write(records)).to eq(formatted_records)
    end
  end

  context "exceptions" do
    it "raises error if file format invalid" do
      expect { described_class.read_from(articles_file) }.to raise_error(Combine::InvalidFileFormatError)
    end
  end
end
