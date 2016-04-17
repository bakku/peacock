module Peacock

  class Formatter

    DIRECTORY_SLASH = '/'

    def self.format_directory_name(directory_name)
      directory_name.tap do |string|
        string.concat(DIRECTORY_SLASH) unless directory_name.end_with?(DIRECTORY_SLASH)
        string.insert(0, DIRECTORY_SLASH) unless directory_name.start_with?(DIRECTORY_SLASH)
      end
    end

  end

end
