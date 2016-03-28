module Combine
  class AuthorsParser < InputParser
    ARTICLES = "articles".freeze
    NAME = "name".freeze

    def run
      json_content.each do |record|
        valid?(record)
        results[record[NAME]] = record[ARTICLES]
      end

      results
    end

    def valid?(record)
      raise Combine::InvalidDataError unless
        record.key?(ARTICLES) && record.key?(NAME)
    end
  end
end
