module Peacock

  class Formatter

    DIRECTORY_SLASH = '/'
    BEGINS_WITH_SLASH_REGEX = /^\//
    ENDS_WITH_SLASH_REGEX = /\/$/

    def self.format_directory_name(directory_name)
      directory_name.tap do |string|
        string.concat(DIRECTORY_SLASH) unless directory_name =~ ENDS_WITH_SLASH_REGEX
        string.insert(0, DIRECTORY_SLASH) unless directory_name =~ BEGINS_WITH_SLASH_REGEX
      end
    end

  end

end
