require "spec_helper"

RSpec.describe Combine::InputParser do
  let(:path) { File.dirname(__FILE__) }

  let(:articles_file) do
    File.join(path, "../support/fixtures/valid_data/articles.csv")
  end

  let(:parsed_articles_contents) do
    {
      "10.1234/altmetric0"   => [{ "Title" => "Small Wooden Chair", "ISSN" => "1337-8688" }],
      "10.1234/altmetric100" => [{ "Title" => "Ergonomic Rubber Shirt", "ISSN" => "25425856" }],
      "10.1234/altmetric103" => [{ "Title" => "Fantastic Granite Computer", "ISSN" => "37750307" }],
      "10.1234/altmetric11"  => [{ "Title" => "Awesome Steel Chair", "ISSN" => "1011-2513" }],
      "10.1234/altmetric461" => [
        { "Title" => "Awesome Cotton Shoes", "ISSN" => "7910-7871" },
        { "Title" => "Intelligent Plastic Hat", "ISSN" => "1240-1326" },
        { "Title" => "Intelligent Steel Car", "ISSN" => "3423-0440" }
      ]
    }
  end

  let(:authors_file) do
    File.join(path, "../support/fixtures/valid_data/authors.json")
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

  let(:journals_file) do
    File.join(path, "../support/fixtures/valid_data/journals.csv")
  end

  let(:parsed_journal_contents) do
    {
      "1337-8688" => "Shanahan, Green and Ziemann",
      "2542-5856" => "Wilkinson, Gaylord and Gerlach",
      "3775-0307" => "Hahn and Sons",
      "6235-7840" => "Grady and Sons",
      "2721-9414" => "Upton Group",
      "3423-0440" => "Emard Group",
      "5039-2276" => "Macejkovic, Paucek and Lowe",
      "7125-4516" => "Friesen-Christiansen",
      "8738-0753" => "Hyatt Group",
      "1011-2513" => "Lesch, Leannon and Schiller",
      "4812-3148" => "Marvin LLC",
      "2175-3233" => "Bernhard LLC",
      "6625-6746" => "Breitenberg, Dietrich and Corkery",
      "7910-7871" => "Wiza, Kirlin and Hoppe",
      "1240-1326" => "Fay Inc"
    }
  end

  it "reads journal file" do
    expect(described_class.new(authors_file).run).to eq(parsed_journal_contents)
  end

  it "reads articles file" do
    expect(described_class.new(articles_file).run).to eq(parsed_articles_contents)
  end

  it "reads authors file" do
    expect(described_class.new(authors_file).run).to eq(parsed_authors_contents)
  end

  context "exceptions" do
    let(:journals_file) do
      File.join(path, "../support/fixtures/valid_data/journals.json")
    end

    let(:articles_file) do
      File.join(path, "../support/fixtures/invalid_data/articles.csv")
    end
    it "raises error if file is wrong type" do
      expect(described_class.new(journals_file).run).to raise_error(Combine::InvalidFileFormatError)
    end

    it "raises error if file data is invalid" do
      expect(described_class.new(authors_file).run).to raise_error(Combine::InvalidDataError)
    end
  end
end
