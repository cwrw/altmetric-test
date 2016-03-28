module Combine
  class InvalidDataError < StandardError
    def message
      %(
        Invalid Data in input file. Please run ruby bin/combine -h
        to see valid files and formats
      )
    end
  end

  class InvalidFileFormatError < StandardError
    def message
      %(
        Invalid file format. Please run ruby bin/combine -h
        to see valid files and formats
      )
    end
  end
end
