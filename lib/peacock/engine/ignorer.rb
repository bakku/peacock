module Peacock
  
  module Engine
  
    class Ignorer
      include Peacock::Engine::Engine
      
      def self.start_engine(opt_hash)
        ignorer = Ignorer.new(opt_hash)
        ignorer.workflow
      end
    
      def initialize(opt_hash)
        @hash = check_and_return_hash(opt_hash)
        @logger = Peacock::Logger.new(@hash.verbose?)
        path = determine_git_ignore_path
        @git_ignore = File.open(path, 'a+')
      end
    
      def workflow
        ignore_files_and_directories
        @git_ignore.close
      end
    
      def ignore_files_and_directories
        ignore_files
        ignore_directories
      end
    
      def ignore_directories
        @hash.dirs.each do |dir|
          check_and_write(dir)
        end
      end
    
      def ignore_files
        @hash.files.each do |file|
          check_and_write(file)
        end
      end
    
      def check_and_write(str)
        unless entry_exists?(str)
          insert_in_gitignore(str)
        end

        @git_ignore.rewind
      end
    
      def entry_exists?(entry)
        @git_ignore.each do |line|
          return true if line.chomp == entry
        end
        false
      end

      def insert_in_gitignore(str)
        @git_ignore.write(str + "\n")
        Git.remove_from_cache(prepare_arg(str))
        @logger.ignore(str)
      end

      # if directory then remove leading slash
      def prepare_arg(str)
        if str.start_with?('/')
          str[1..-1]
        else
          str
        end
      end
    
    end
    
  end
  
end

