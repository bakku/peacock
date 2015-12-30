module Git
  class Base
    
    # wrapper for command method which returns the output
    def self.command_output(command = '', opts = '')
      f = command(command, opts)
      output = f.readlines.join
      f.close
      output
    end
  
    # wrapper for git commands
    def self.command(command = '', opts = '')
      IO.popen("git #{command} #{opts}") # 2>&1 surpresses stderr
    end
    
  end
end