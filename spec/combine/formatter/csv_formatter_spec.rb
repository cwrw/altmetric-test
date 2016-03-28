require "spec_helper"

RSpec.describe Formatter::CsvFormatter do
  let(:path) { File.dirname(__FILE__) }

  let(:file) do
    File.join(path, "../../support/fixtures/valid_data/articles.csv")
  end

  it "reads csv file" do
    expect { described_class.read_from(file) }.to_not raise_error
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
