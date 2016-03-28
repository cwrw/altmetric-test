require "spec_helper"

RSpec.describe Combine do
  include_context "file data setup"
  let(:formatter) { Formatter::JSONFormatter }

  subject do
    described_class.new(
      formatter: formatter,
      articles_file: articles_file,
      authors_file: authors_file,
      journals_file: journals_file
    )
  end

  describe "#generate" do
    context "json formatter" do
      let(:message) do
        fixture_full_articles_json
      end

      it "output linked records in json" do
        expect { subject.generate }.to output(message).to_stdout
      end
    end

    context "csv formatter" do
      let(:formatter) { Formatter::CsvFormatter }
      let(:message) do
        fixture_full_articles_csv
      end

      it "output linked records in csv" do
        expect { subject.generate }.to output(message).to_stdout
      end
    end
  end

  context "exceptions" do
    it "outputs error message if exception occurs" do
      allow(Combine::AuthorsParser).to receive(:new).and_raise("Boom!")
      expect { subject.generate }.to raise_error("Boom!")
    end
  end
end
