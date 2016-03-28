module Combine
  class InputParser
    attr_reader :file, :results

    def initialize(file)
      @file = file
      @results = {}
    end

    def raise_not_implemented
      raise NotImplementedError, "This should be overriden"
    end

    alias_method :run,             :raise_not_implemented
    alias_method :valid?,          :raise_not_implemented
    alias_method :extract_content, :raise_not_implemented

    private

    def csv_content
      @_csv_content ||= CSV.read(file).reject(&:empty?)
    end

    def json_content
      @_json_content ||= JSON.parse(File.read(file))
    end

    def format_issn(key)
      key.include?("-") ? key : key.gsub(/(.{4})(?=.)/, '\1-')
    end
  end
end
