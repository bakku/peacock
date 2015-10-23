# Available Git commands
module Git
  
  module Lib
    
    def self.git
      Git::Base.command_output
    end
    
    def self.init
      Git::Base.command_output('init')
    end
    
    def self.status
      Git::Base.command_output('status')
    end
    
    def self.commit_all(message)
      Git::Base.command_output('add', '-A')
      Git::Base.command_output('commit', "-m '#{message}'")
    end
    
    def self.clear_cache
      Git::Base.command_output('rm', '-r --cached .')
    end
    
    def self.log
      Git::Base.command_output('log')
    end
    
  end
  
end
