module Formatter
  module CsvFormatter
    ACCEPTED_FORMATS = [".csv"].freeze

    def self.read_from(input)
      validate_format(input)
      CSV.read(input).reject(&:empty?)
    end

    def self.validate_format(file)
      raise ::Combine::InvalidFileFormatError unless
        ACCEPTED_FORMATS.include? File.extname(file)
    end
  end
end
