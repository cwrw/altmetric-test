require "spec_helper"

RSpec.feature "Combine" do
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

  let(:files) { "#{journals_file} #{articles_file} #{authors_file}" }

  let(:full_articles_csv) do
    File.join(path, "../../tmp/full_articles.csv")
  end

  let(:full_articles_json) do
    File.join(path, "../../tmp/full_articles.json")
  end

  context "valid data" do
    let(:fixture_full_articles_csv) do
      File.read(File.join(path, "../support/fixtures/valid_data/full_articles.csv"))
    end

    let(:fixture_full_articles_json) do
      File.read(File.join(path, "../support/fixtures/valid_data/full_articles.json"))
    end

    context "json format" do
      after do
        FileUtils.rm([full_articles_json])
      end
      scenario "outputs combined json file" do
        `ruby bin/combine --format json #{files} > #{full_articles_json}`
        expect(File.read(full_articles_json)).to eq(fixture_full_articles_json)
      end
    end

    context "csv format" do
      after do
        FileUtils.rm([full_articles_csv])
      end

      scenario "outputs combined csv file" do
        `ruby bin/combine --format csv #{files} > #{full_articles_csv}`
        expect(File.read(full_articles_csv)).to eq(fixture_full_articles_csv)
      end
    end
  end

  context "invalid data" do
    scenario "wrong format specified" do
      `ruby bin/combine --format xml #{files} >&1`
      expect($CHILD_STATUS.exitstatus).to eq(1)
    end

    scenario "missing file entry" do
      files = "#{journals_file} #{articles_file}"
      `ruby bin/combine --format csv #{files} >&1`
      expect($CHILD_STATUS.exitstatus).to eq(1)
    end
  end
end
