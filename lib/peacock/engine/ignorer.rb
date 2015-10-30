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
        Git.commit_all('peacock: before .gitignore commit')
        ignore_files_and_directories
        Git.clear_cache
        Git.commit_all('peacock: after .gitignore commit')
        @git_ignore.close
      end
    
      def ignore_files_and_directories
        ignore_files
        ignore_directories
      end
    
      def ignore_directories
        @hash.dirs.each do |dir|
          dir = dir + '/' unless dir =~ /\/$/  # add backlash to dir name if it does not exist yet
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
          @git_ignore.write(str + "\n")
          @logger.ignore(str)
        end
      
        @git_ignore.rewind
      end
    
      def entry_exists?(entry)
        @git_ignore.each do |line|
          return true if line.chomp == entry
        end
        false
      end
    
    end
    
  end
  
end

