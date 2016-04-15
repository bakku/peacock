module Git
  class Base
    
    # wrapper for command method which returns the output
    def self.command_with_output(command = '', opts = '')
      command(command, opts).readlines.join
    end
  
    # wrapper for git commands
    def self.command(command = '', opts = '')
      IO.popen("git #{command} #{opts} 2>&1") # 2>&1 surpresses stderr
    end
    
  end
end