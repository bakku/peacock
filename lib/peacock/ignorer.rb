module Peacock

  class Ignorer
    
    def self.ignore(opt_hash)
      ignorer = Ignorer.new(opt_hash)
      ignorer.ignore_files_and_directories
    end
    
    def initialize(opt_hash)
      @hash = opt_hash
      @git_ignore = File.open('.gitignore', 'a')
    end
    
    def ignore_files_and_directories
      ignore_files
    end
    
    def ignore_files
      @hash[:files].each do |file|
        @git_ignore.write file + "\n"
      end
    end
    
  end
  
end
