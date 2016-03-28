require "spec_helper"

RSpec.describe Combine::InputParser do
  let(:path) { File.dirname(__FILE__) }
  let(:file) do
    File.join(path, "../support/fixtures/valid_data/journals.csv")
  end
  let(:formatter) { Formatter::CsvFormatter }

  describe "#raise_not_implemented" do
    it "raises implementation error" do
      expect { described_class.new(file, formatter).raise_not_implemented }
        .to raise_exception(NotImplementedError)
    end
  end
end
