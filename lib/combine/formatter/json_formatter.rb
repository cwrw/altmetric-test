module Formatter
  module JSONFormatter
    ACCEPTED_FORMATS = [".json"].freeze

    def self.read_from(input)
      validate_format(input)
      JSON.parse(File.read(input))
    end

    def self.write(records)
      records.map(&:to_h).to_json
    end

    def self.validate_format(file)
      raise ::Combine::InvalidFileFormatError unless
        ACCEPTED_FORMATS.include? File.extname(file)
    end
  end
end
