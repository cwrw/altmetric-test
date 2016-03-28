require "spec_helper"

RSpec.describe Formatter::CsvFormatter do
  let(:path) { File.dirname(__FILE__) }

  let(:file) do
    File.join(path, "../../support/fixtures/valid_data/articles.csv")
  end

  describe "#read_from" do
    it "reads csv file" do
      expect { described_class.read_from(file) }.to_not raise_error
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
      "DOI,Article title,Author name,Journal title,Journal ISSN\n" \
        "doi,title,author,journal,issn\n"
    end

    it "transforms objects to csv format" do
      expect(described_class.write(records)).to eq(formatted_records)
    end
  end

  context "exceptions" do
    let(:file) do
      File.join(path, "../../support/fixtures/valid_data/authors.json")
    end

    it "raises error if file format invalid" do
      expect { described_class.read_from(file) }.to raise_error(Combine::InvalidFileFormatError)
    end
  end
end
