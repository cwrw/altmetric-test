require "spec_helper"

RSpec.describe Combine::InputParser do
  include_context "file data setup"
  let(:formatter) { Formatter::CsvFormatter }

  describe "#raise_not_implemented" do
    it "raises implementation error" do
      expect { described_class.new(journals_file, formatter).raise_not_implemented }
        .to raise_exception(NotImplementedError)
    end
  end
end
