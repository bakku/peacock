module Peacock

  class Parser
    
    def self.parse
      parser = Parser.new
      parser.check_if_help
    end
    
    def check_if_help
      puts help_text if should_print_help?
    end
    
    def should_print_help?
      ARGV.size == 0 || ARGV[0] == '-h' || ARGV[0] == '--help'
    end
    
    def help_text
      <<-EOF.gsub /^ */, ''
        Usage: 
          \tpeacock [options] [files/directories]
        
        Options:
          \t-h, [--help]           # show this text
          \t-r, [--root]           # use root .gitignore (not functional yet)
          \t-e, [--extract]        # extract file from .gitignore (not functional yet)
      EOF
    end
    
  end  
  
end

