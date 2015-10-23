require 'git/base'
require 'git/error'
require 'git/lib'

module Git
  
  # checks if git is installed
  def self.check_git_existance
    output = git
    
    unless /\Ausage: git/ =~ output
      raise NoGitInstalledError, 'git was not found. make sure you have it installed'
    end
  end
  
  # checks if current directory is a git repository
  def self.check_repo_existance
    output = status
    
    unless /\AOn branch/ =~ output
      raise NoGitRepositoryError, 'you are not in a git repository.'
    end
  end
  
  # so Git calls follow the Git.<command> pattern
  def self.git
    Git::Lib.git
  end
  
  def self.init
    Git::Lib.init
  end
  
  def self.status
    Git::Lib.status
  end
  
  def self.commit_all(message)
    Git::Lib.commit_all(message)
  end
  
  def self.clear_cache
    Git::Lib.clear_cache
  end
  
  def self.log
    Git::Lib.log
  end
  
end
