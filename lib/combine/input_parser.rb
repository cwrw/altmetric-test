module Combine
  class InputParser
    attr_reader :file, :results, :formatter

    def initialize(file, formatter)
      @file = file
      @formatter = formatter
      @results = {}
    end

    def raise_not_implemented
      raise NotImplementedError, "This should be overriden"
    end

    alias_method :run,             :raise_not_implemented
    alias_method :valid?,          :raise_not_implemented
    alias_method :extract_content, :raise_not_implemented

    private

    def content
      @_content ||= formatter.read_from(file)
    end

    def format_issn(key)
      key.include?("-") ? key : key.gsub(/(.{4})(?=.)/, '\1-')
    end
  end
end
