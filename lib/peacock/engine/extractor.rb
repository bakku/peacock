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
        @git_ignore = File.open(path, 'a+')
      end
      
      def workflow
        extract_files_and_directories
        @git_ignore.close
      end
      
      def extract_files_and_directories
        extract_files
        extract_directories
      end
      
      def extract_files
        
      end
      
      def extract_directories
        
      end
    
    end
    
  end
  
end      