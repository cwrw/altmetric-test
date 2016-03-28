class Combine
  attr_reader :formatter, :journals_file, :articles_file,
    :authors_file, :full_articles, :records

  def initialize(formatter:, journals_file:, articles_file:, authors_file:)
    @formatter = formatter
    @journals_file = journals_file
    @articles_file = articles_file
    @authors_file = authors_file
    @records = []
  end

  def generate
    puts output
  end

  private

  def output
    link_records
    formatter.write(records)
  rescue => e
    "Unable to process files due to: #{e.message}"
  end

  def link_records
    authors.each do |name, dois|
      dois.each do |doi|
        articles[doi].each do |article|
          record = create_record(doi, article["Title"], name, article["ISSN"])
          records << record if record.valid?
        end
      end
    end
  end

  def journals
    @_journals ||=
      Combine::JournalsParser.new(journals_file, Formatter::CsvFormatter).run
  end

  def articles
    @_articles ||=
      Combine::ArticlesParser.new(articles_file, Formatter::CsvFormatter).run
  end

  def authors
    @_authors ||=
      Combine::AuthorsParser.new(authors_file, Formatter::JSONFormatter).run
  end

  def create_record(doi, title, name, issn)
    Combine::Record.new(
      doi: doi,
      title: title,
      author: name,
      journal: journals[issn],
      issn: issn
    )
  end
end
