# Available Git commands
module Git
  
  module Lib
    
    def self.git
      Git::Base.command_with_output
    end
    
    def self.init
      Git::Base.command_with_output('init')
    end
    
    def self.status
      Git::Base.command_with_output('status')
    end
    
    def self.commit_all(message)
      Git::Base.command('add', '-A')
      Git::Base.command_with_output('commit', "-m '#{message}'")
    end
    
    def self.clear_cache
      Git::Base.command_with_output('rm', '-r --cached .')
    end

    def self.remove_from_cache(path)
      Git::Base.command_with_output('rm', "-rf --cached #{path}")
    end
    
    def self.log
      Git::Base.command_with_output('log')
    end
    
  end
  
end
