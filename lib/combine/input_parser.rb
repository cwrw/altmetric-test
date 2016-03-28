module Combine
  class InputParser
    DOI = "DOI".freeze
    TITLE = "Title".freeze
    ISSN = "ISSN".freeze
    ARTICLES = "articles".freeze
    NAME = "name".freeze

    attr_reader :file, :articles, :journals, :authors

    def initialize(file)
      @file = file
      @articles = {}
      @journals = {}
      @authors  = {}
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

    def csv_content
      @_csv_content ||= CSV.read(file).reject(&:empty?)
    end

    def json_content
      @_json_content ||= JSON.parse(File.read(file))
    end

    def authors_parser
      extract_authors_content
    end

    def extract_authors_content
      json_content.each do |record|
        raise Combine::InvalidDataError unless record.key?(ARTICLES) && record.key?(NAME)
        authors[record["name"]] = record["articles"]
      end

      authors
    end

    def journals_parser
      header = csv_content.shift
      raise Combine::InvalidDataError unless journals_header_valid?(header)
      extract_journals_content
    end

    def journals_header_valid?(header)
      header.compact == [TITLE, ISSN]
    end

    def extract_journals_content
      csv_content.each do |row|
        journals[format_issn(row[1])] = row[0]
      end

      journals
    end

    def articles_parser
      header = csv_content.shift
      raise Combine::InvalidDataError unless articles_header_valid?(header)
      extract_articles_content
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
        "ISSN" => format_issn(row[2])
      }
    end

    def format_issn(key)
      key.include?("-") ? key : key.gsub(/(.{4})(?=.)/, '\1-')
    end
  end
end
