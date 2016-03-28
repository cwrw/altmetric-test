require "spec_helper"

RSpec.describe Combine::AuthorsParser do
  let(:path) { File.dirname(__FILE__) }

  let(:authors_file) do
    File.join(path, "../../support/fixtures/valid_data/authors.json")
  end

  let(:parsed_authors_contents) do
    {
      "Amari Lubowitz" => [
        "10.1234/altmetric461",
        "10.1234/altmetric0"
      ],
      "Lenny Kshlerin" => [
        "10.1234/altmetric100"
      ],
      "Howard Spinka Jr." => [
        "10.1234/altmetric103"
      ],
      "Dr. Chandler Flatley" => [
        "10.1234/altmetric11"
      ]
    }
  end

  let(:formatter) { Formatter::JSONFormatter }

  it "reads authors file" do
    expect(Combine::AuthorsParser.new(authors_file, formatter).run).to eq(
      parsed_authors_contents
    )
  end

  context "exceptions" do
    let(:authors_file) do
      File.join(path, "../../support/fixtures/invalid_data/authors.json")
    end

    it "raises error if file data is invalid" do
      expect { described_class.new(authors_file, formatter).run }.to raise_error(
        Combine::InvalidDataError
      )
    end
  end
end
