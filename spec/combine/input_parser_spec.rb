require "spec_helper"

RSpec.describe Combine::InputParser do
  let(:path) { File.dirname(__FILE__) }
  let(:file) do
    File.join(path, "../support/fixtures/valid_data/journals.csv")
  end

  describe "#raise_not_implemented" do
    it "raises implementation error" do
      expect { described_class.new(file).raise_not_implemented }
        .to raise_exception(NotImplementedError)
    end
  end

  context "exceptions" do
    let(:journals_file) do
      File.join(path, "../support/fixtures/valid_data/journals.json")
    end

    xit "raises error if file is wrong type" do
      expect { Combine::JournalsParser.new(journals_file).run }.to raise_error(Combine::InvalidFileFormatError)
    end
  end
end
