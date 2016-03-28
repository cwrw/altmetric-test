module Combine
  class InputParser
    DOI = "DOI".freeze
    TITLE = "Title".freeze
    ISSN = "ISSN".freeze

    attr_reader :file, :articles

    def initialize(file)
      @file = file
      @articles = {}
    end

    def run
      if file =~ /articles.csv/
        articles_parser
      elsif file =~ /journals.csv/
        journals_parser
      elsif file =~ /authors.json/
        authors_parser
      else
        raise Combine::InvalidFileFormatError
      end
    end

    private

    def articles_parser
      header = csv_content.shift
      raise RateCalculatorSystem::InvalidDataError unless articles_header_valid?(header)
      extract_articles_content
    end

    def csv_content
      @_csv_content ||= CSV.read(file)
    end

    def articles_header_valid?(header)
      header.compact == [DOI, TITLE, ISSN]
    end

    def extract_articles_content
      csv_content.each do |row|
        articles[row[0]] ||= []
        articles[row[0]] << create_article(row.compact)
      end

      articles
    end

    def create_article(row)
      {
        "Title" => row[1],
        "ISSN" => row[2]
      }
    end
  end
end
