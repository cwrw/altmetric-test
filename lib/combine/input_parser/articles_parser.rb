class Combine
  class ArticlesParser < InputParser
    DOI = "DOI".freeze
    TITLE = "Title".freeze
    ISSN = "ISSN".freeze

    def run
      header = content.shift
      valid?(header)
      extract_content
    end

    def valid?(header)
      raise Combine::InvalidDataError unless
        header.compact == [DOI, TITLE, ISSN]
    end

    def extract_content
      content.each do |row|
        results[row[0]] ||= []
        results[row[0]] << create_article(row.compact)
      end

      results
    end

    def create_article(row)
      {
        "Title" => row[1],
        "ISSN" => format_issn(row[2])
      }
    end
  end
end
