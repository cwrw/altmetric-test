require "spec_helper"

RSpec.describe Combine do
  let(:path) { File.dirname(__FILE__) }

  let(:articles_file) do
    File.join(path, "../support/fixtures/valid_data/articles.csv")
  end

  let(:authors_file) do
    File.join(path, "../support/fixtures/valid_data/authors.json")
  end

  let(:journals_file) do
    File.join(path, "../support/fixtures/valid_data/journals.csv")
  end

  let(:fixture_full_articles_csv) do
    File.read(File.join(path, "../support/fixtures/valid_data/full_articles.csv"))
  end

  let(:fixture_full_articles_json) do
    File.read(File.join(path, "../support/fixtures/valid_data/full_articles.json"))
  end

  let(:format) { "json" }

  subject do
    described_class.new(
      format: format,
      articles_file: articles_file,
      authors_file: authors_file,
      journals_file: journals_file
    )
  end

  describe "#generate" do
    context "json format" do
      let(:message) do
        fixture_full_articles_json
      end

      it "output linked records in json" do
        expect { subject.generate }.to output(message).to_stdout
      end
    end

    context "csv format" do
      let(:format) { "csv" }
      let(:message) do
        fixture_full_articles_csv
      end

      it "output linked records in csv" do
        expect { subject.generate }.to output(message).to_stdout
      end
    end
  end

  context "exceptions" do
    let(:message) do
      "Unable to process files due to: Boom!\n"
    end

    it "outputs error message if exception occurs" do
      allow(Combine::AuthorsParser).to receive(:new).and_raise("Boom!")
      expect { subject.generate }.to output(message).to_stdout
    end
  end
end
