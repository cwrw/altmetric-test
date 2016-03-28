class Combine
  class Record
    attr_reader :doi, :title, :author, :journal, :issn
    HEADER = ["DOI", "Article title", "Author name", "Journal title", "Journal ISSN"].freeze

    def initialize(options = {})
      @doi = options.fetch(:doi)
      @title = options.fetch(:title)
      @author = options.fetch(:author)
      @journal = options.fetch(:journal)
      @issn = options.fetch(:issn)
    end

    def valid?
      doi && title && author &&
        journal && issn
    end

    def to_h
      {
        "doi": doi,
        "title": title,
        "author": author,
        "journal": journal,
        "issn": issn
      }
    end

    def to_a
      [doi, title, author, journal, issn]
    end
  end
end
