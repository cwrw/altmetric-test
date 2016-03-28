class Combine
  class Record
    attr_reader :doi, :title, :author, :journal, :issn

    def initialize(options = {})
      @doi = options.fetch(:doi)
      @title = options.fetch(:title)
      @author = options.fetch(:author)
      @journal = options.fetch(:journal)
      @issn = options.fetch(:issn)
    end

    def ==(other)
      other.is_a?(FullArticle) &&
        other.doi == doi &&
        other.title == title &&
        other.author == author &&
        other.journal == journal &&
        other.issn == issn
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
