module Peacock

  class Formatter

    def self.format_dir(str)
      str.tap do |string|
        string.concat('/') unless str =~ /\/$/      # add backlash to dir name if it does not exist yet
        string.insert(0, '/') unless str =~ /^\//   # add backlash to beginning of dir name if it does not exist yet
      end
    end

  end

end
