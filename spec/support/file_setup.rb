RSpec.shared_context "file data setup" do
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

  let(:invalid_articles_file) do
    File.join(path, "../support/fixtures/invalid_data/articles.csv")
  end

  let(:invalid_authors_file) do
    File.join(path, "../support/fixtures/invalid_data/authors.json")
  end

  let(:invalid_journals_file) do
    File.join(path, "../support/fixtures/invalid_data/journals.csv")
  end

  let(:files) { "#{journals_file} #{articles_file} #{authors_file}" }

  let(:full_articles_csv) do
    File.join(path, "../../tmp/full_articles.csv")
  end

  let(:full_articles_json) do
    File.join(path, "../../tmp/full_articles.json")
  end

  let(:fixture_full_articles_csv) do
    File.read(File.join(path, "../support/fixtures/valid_data/full_articles.csv"))
  end

  let(:fixture_full_articles_json) do
    File.read(File.join(path, "../support/fixtures/valid_data/full_articles.json"))
  end
end
