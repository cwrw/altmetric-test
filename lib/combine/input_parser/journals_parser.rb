class Combine
  class JournalsParser < InputParser
    TITLE = "Title".freeze
    ISSN = "ISSN".freeze

    def run
      header = content.shift
      valid?(header)
      extract_content
    end

    def valid?(header)
      raise Combine::InvalidDataError unless
        header.compact == [TITLE, ISSN]
    end

    def extract_content
      content.each do |row|
        results[format_issn(row[1])] = row[0]
      end

      results
    end
  end
end
