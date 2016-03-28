require "spec_helper"

RSpec.describe Formatter::CsvFormatter do
  include_context "file data setup"
  let(:output) do
    [
      ["DOI", "Title", "ISSN"],
      ["10.1234/altmetric461", "Awesome Cotton Shoes", "7910-7871"],
      ["10.1234/altmetric461", "Intelligent Plastic Hat", "1240-1326"],
      ["10.1234/altmetric461", "Intelligent Steel Car", "3423-0440"],
      ["10.1234/altmetric0", "Small Wooden Chair", "1337-8688"],
      ["10.1234/altmetric100", "Ergonomic Rubber Shirt", "25425856"],
      ["10.1234/altmetric103", "Fantastic Granite Computer", "37750307"],
      ["10.1234/altmetric11", "Awesome Steel Chair", "1011-2513"]
    ]
  end
  describe "#read_from" do
    it "reads csv file" do
      expect(described_class.read_from(articles_file)).to eq(output)
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
    it "raises error if file format invalid" do
      expect { described_class.read_from(authors_file) }.to raise_error(Combine::InvalidFileFormatError)
    end
  end
end
