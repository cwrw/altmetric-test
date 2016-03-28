module Formatter
  module CsvFormatter
    ACCEPTED_FORMATS = [".csv"].freeze

    def self.read_from(input)
      validate_format(input)
      CSV.read(input).reject(&:empty?)
    end

    def self.write(records)
      CSV.generate do |csv|
        csv << records.first.class::HEADER
        records.each do |record|
          csv << record.to_a
        end
      end
    end

    def self.validate_format(file)
      raise ::Combine::InvalidFileFormatError unless
        ACCEPTED_FORMATS.include? File.extname(file)
    end
  end
end
