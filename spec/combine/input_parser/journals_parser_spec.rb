require "spec_helper"

RSpec.describe Combine::JournalsParser do
  let(:path) { File.dirname(__FILE__) }

  let(:journals_file) do
    File.join(path, "../../support/fixtures/valid_data/journals.csv")
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
    expect(Combine::JournalsParser.new(journals_file).run).to eq(parsed_journal_contents)
  end

  context "exceptions" do
    let(:journals_file) do
      File.join(path, "../../support/fixtures/invalid_data/journals.csv")
    end

    it "raises error if file data is invalid" do
      expect { described_class.new(journals_file).run }.to raise_error(Combine::InvalidDataError)
    end
  end
end
