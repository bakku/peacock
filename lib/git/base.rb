module Git
  class Base
    
    def self.command_with_output(command = '', opts = '')
      output_stream = base_command(command, opts)
      output_as_string = output_stream.readlines.join
      output_stream.close
      output_as_string
    end
  
    def self.command(command = '', opts = '')
      base_command(command, opts).close
    end

    def self.base_command(command = '', opts = '')
      IO.popen("git #{command} #{opts} 2>&1") # 2>&1 surpresses stderr
    end
    
  end
end