module Peacock
  
  class Logger
  
    def initialize(verbose)
      @verbose = verbose
    end
    
    def ignore(string)
      puts 'added #{string} to .gitignore' unless @verbose
    end
    
    def extract(string)
      puts 'removed #{string} from .gitignore' unless @verbose
    end
    
  end
  
end