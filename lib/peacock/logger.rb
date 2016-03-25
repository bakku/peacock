module Peacock

  class Logger

    def initialize(silent)
      @silent = silent
    end

    def ignore(string)
      puts "added #{string} to .gitignore" unless @silent
    end

    def extract(string)
      puts "removed #{string} from .gitignore" unless @silent
    end

  end

end
