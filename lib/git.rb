require 'git/base'
require 'git/error'

module Git
  
  # checks if git is installed
  def self.check_git_existance
    output = Git::Base.command_output
    
    unless /\Ausage: git/ =~ output
      raise NoGitInstalledError, 'git was not found. make sure you have it installed'
    end
  end
  
  # checks if current directory is a git repository
  def self.check_repo_existance
    output = Git::Base.command_output('status')
    
    unless /\AOn branch/ =~ output
      raise NoGitRepositoryError, 'you are not in a git repository.'
    end
  end
end
