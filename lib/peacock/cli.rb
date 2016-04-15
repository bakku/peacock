module Peacock

  class CLI

    def self.construct_cli_hash
      parser = CLI.new
      parser.check_if_help_text
      parser.create_cli_hash_from_arguments
    end

    def initialize
      @cli_hash = Peacock::CLIHash.new
      @argument_splitter = Peacock::ArgumentSplitter.new
    end

    def create_cli_hash_from_arguments
      @argument_splitter.split_multiple_arguments!
      parse_arguments_into_cli_hash
    end

    def parse_arguments_into_cli_hash
      ARGV.each do |arg|
        type = determine_argument_type arg
        @cli_hash.push(type, arg) unless type.nil?
      end

      @cli_hash
    end

    def determine_argument_type(opt)
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
      <<-EOF.gsub(/^ */, '')
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
