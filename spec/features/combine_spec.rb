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

  after(:all) do
    FileUtils.rm([full_articles_csv])
    FileUtils.rm([full_articles_json])
  end

  context "valid data" do
    let(:fixture_full_articles_csv) do
      File.read(File.join(path, "../support/fixtures/valid_data/full_articles.csv"))
    end

    let(:fixture_full_articles_json) do
      File.read(File.join(path, "../support/fixtures/valid_data/full_articles.json"))
    end

    scenario "outputs combined csv file" do
      `ruby bin/combine --format csv #{files} > #{full_articles_csv}`
      expect(File.read(full_articles_csv)).to eq(fixture_full_articles_csv)
    end

    scenario "outputs combined json file" do
      `ruby bin/combine --format json #{files} > #{full_articles_json}`
      expect(File.read(full_articles_json)).to eq(fixture_full_articles_json)
    end
  end

  context "invalid data" do
    context "format type" do
      scenario "wrong format specified" do
        command = `ruby bin/combine --format xml #{files} > #{full_articles_csv}`
        expect(command).to match("Invalid format, format is eather json or csv")
      end

      scenario "wrong format specified in full articles file" do
        invalid_format_file = File.join(path, "../../tmp/full_articles.xml")
        command = `ruby bin/combine --format csv #{files} > #{invalid_format_file}`
        expect(command).to match(/Invalid format, format is eather json or csv/)
      end
    end
    scenario "missing file entry" do
      files = "#{journals_file} #{articles_file}"
      command = `ruby bin/combine --format csv #{files} > #{full_articles_csv}`
      expect(command).to match(/Invalid number of input files/)
    end

    context "data in input" do
      let(:articles_file) do
        File.join(path, "../support/fixtures/invalid_data/articles.csv")
      end

      scenario "missing column in data input" do
        command = `ruby bin/combine --format json #{files} > #{full_articles_json}`
        expect(command).to match(/Data in files invalid/)
      end
    end

    scenario "fail silently when data missing?"
  end
end
