# some general engine code

module Peacock
  
  module Engine
    
    def self.execute(opt_hash)
      opt_hash.engine.start_engine(opt_hash)  # opt_hash.engine returns the engine as a class on which we will call the general method start_engine
    end
    
    module Engine
      
      def check_and_return_hash(opt_hash)
        raise PeacockError, '#{self.class} expects an instance of Peacock::CLIHash' unless opt_hash.class == CLIHash
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
      
    end
    
  end

end
