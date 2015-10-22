module Peacock
  
  class StartupManager
    
    def self.check_peacock_requirements
      Git.check_git_existance
      Git.check_repo_existance
    end
    
  end
  
end
