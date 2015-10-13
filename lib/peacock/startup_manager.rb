module Peacock
  
  class StartupManager
    
    def check_peacock_requirements
      begin
        check_git_repository
      rescue PeacockError
        puts 'An error occured. Make sure you are in a git repository and git is installed.'
        exit 1
      end
    end
    
    def check_git_repository
      raise PeacockError unless git_repository?
    end
    
    # checks if current directory is a git repository
    def git_repository?
      begin
        Git.open Dir.pwd
        true
      rescue
        false
      end
    end
    
  end
  
end
