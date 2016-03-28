require "spec_helper"

RSpec.describe Formatter::JSONFormatter do
  include_context "file data setup"
  let(:output) do
    [
      { "name" => "Amari Lubowitz", "articles" => ["10.1234/altmetric461", "10.1234/altmetric0"] },
      { "name" => "Lenny Kshlerin", "articles" => ["10.1234/altmetric100"] },
      { "name" => "Howard Spinka Jr.", "articles" => ["10.1234/altmetric103"] },
      { "name" => "Dr. Chandler Flatley", "articles" => ["10.1234/altmetric11"] }
    ]
  end

  describe "#read_from" do
    it "reads json file" do
      expect(described_class.read_from(authors_file)).to eq(output)
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
