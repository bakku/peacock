module Peacock

  class Ignorer
    
    def self.ignore(opt_hash)
      ignorer = Ignorer.new(opt_hash)
      ignorer.workflow
    end
    
    def initialize(opt_hash)
      @hash = check_and_return_hash(opt_hash)
      path = determine_git_ignore_path
      @git_ignore = File.open(path, 'a+')
    end
    
    def check_and_return_hash(opt_hash)
      raise PeacockError, 'Peacock::Ignorer expects an instance of Peacock::CLIHash' unless opt_hash.class == Peacock::CLIHash
      opt_hash
    end
    
    def determine_git_ignore_path
      if @hash.root_ignore?
        determine_root_dir
      else
        '.gitignore'
      end
    end
    
    def determine_root_dir
      old_path = Dir.pwd
      while not Dir.exists? '.git'
        Dir.chdir '..'
      end
      
      path = Dir.pwd() + '/.gitignore'
      Dir.chdir(old_path)
      path
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
      @hash[:dirs].each do |dir|
        dir = dir + '/' unless dir =~ /\/$/  # add backlash to dir name if it does not exist yet
        check_and_write(dir)
      end
    end
    
    def ignore_files
      @hash[:files].each do |file|
        check_and_write(file)
      end
    end
    
    def check_and_write(str)
      @git_ignore.write(str + "\n")  unless entry_exists?(str)
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

