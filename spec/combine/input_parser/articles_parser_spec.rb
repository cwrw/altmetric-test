require "spec_helper"

RSpec.describe Combine::ArticlesParser do
  let(:path) { File.dirname(__FILE__) }

  let(:articles_file) do
    File.join(path, "../../support/fixtures/valid_data/articles.csv")
  end

  let(:parsed_articles_contents) do
    {
      "10.1234/altmetric0"   => [{ "Title" => "Small Wooden Chair", "ISSN" => "1337-8688" }],
      "10.1234/altmetric100" => [{ "Title" => "Ergonomic Rubber Shirt", "ISSN" => "2542-5856" }],
      "10.1234/altmetric103" => [{ "Title" => "Fantastic Granite Computer", "ISSN" => "3775-0307" }],
      "10.1234/altmetric11"  => [{ "Title" => "Awesome Steel Chair", "ISSN" => "1011-2513" }],
      "10.1234/altmetric461" => [
        { "Title" => "Awesome Cotton Shoes", "ISSN" => "7910-7871" },
        { "Title" => "Intelligent Plastic Hat", "ISSN" => "1240-1326" },
        { "Title" => "Intelligent Steel Car", "ISSN" => "3423-0440" }
      ]
    }
  end

  it "reads articles file" do
    expect(described_class.new(articles_file).run).to eq(parsed_articles_contents)
  end

  context "exceptions" do
    let(:articles_file) do
      File.join(path, "../../support/fixtures/invalid_data/articles.csv")
    end

    it "raises error if file data is invalid" do
      expect { described_class.new(articles_file).run }.to raise_error(Combine::InvalidDataError)
    end
  end
end
