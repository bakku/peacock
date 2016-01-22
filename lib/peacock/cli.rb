module Peacock

  class CLI
    
    def self.parse
      parser = CLI.new
      parser.check_if_help_text
      parser.parse_args
    end
    
    def parse_args
      return_hash = Peacock::CLIHash.new

      normalize_args!

      ARGV.each do |arg|
        type = determine_type arg
        return_hash.push(type, arg) unless type.nil?
      end
      
      return_hash
    end

    # takes every argument which follows the pattern as this: -ev, splits it to -e -v and adds it to ARGV
    def normalize_args!
      ARGV.each do |arg|
        if arg.start_with?('-') && arg.size > 2
          ARGV.delete(arg)
          temp_ary = arg.split('')

          temp_ary.each do |elem|
            next if elem == '-'
            ARGV << "-#{elem}"
          end
        end
      end
    end
    
    def determine_type(opt)
      if File.directory?(opt)
        :dirs
      elsif File.file?(opt)
        :files
      elsif options.include?(opt)
        :opts
      else
        nil
      end
    end
    
    def check_if_help_text
      if should_print_help?
        puts help_text
        exit 0
      end
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
          \t-r, [--root]           # use root .gitignore
          \t-s, [--silent]         # surpress output
          \t-e, [--extract]        # extract file from .gitignore
      EOF
    end
    
    def options
      %w(-r --root -e --extract -s --silent)
    end
    
  end
  
end

