module Combine
  class InvalidDataError < StandardError
    def message
      %(
        Invalid Data
      )
    end
  end

  class InvalidFileFormatError < StandardError
    def message
      %(
        Invalid File
      )
    end
  end
end
