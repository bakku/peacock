module Peacock
  
  class StartupManager
    
    def check_peacock_requirements
      check_git_repository
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
