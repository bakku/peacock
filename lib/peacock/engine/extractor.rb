module Peacock
  
  module Engine
    
    class Extractor
      include Peacock::Engine::Engine
      
      def self.start_engine(opt_hash)
        extractor = Extractor.new(opt_hash)
        extractor.workflow
      end
      
      def initialize(opt_hash)
        @hash = check_and_return_hash(opt_hash)
        @logger = Peacock::Logger.new(@hash.verbose?)
        path = determine_git_ignore_path
        git_ignore_exists?(path)

        # open in mode read-write (beginning of file)
        @git_ignore = File.open(path, 'r')
      end
      
      def workflow
        extract_files_and_directories
        @git_ignore.close
      end
      
      def extract_files_and_directories
        ignore_lines = @git_ignore.readlines

        ignore_lines.delete_if do |line|
          @hash.dirs.include?(line.chomp("\n")) || @hash.files.include?(line.chomp("\n"))
        end

        @git_ignore.reopen(@git_ignore.path, 'w')

        ignore_lines.each do |line|
          @git_ignore.write(line)
        end
      end
    
    end
    
  end
  
end      