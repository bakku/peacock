class Git
  def initialize
    check_git_existance
    check_repo_existance
  end
  
  def check_git_existance
    output = command_output
    
    unless /\Ausage: git/ =~ output
      raise Peacock::PeacockError, 'git was not found. make sure you have it installed'
    end
  end
  
  def check_repo_existance
    output = command_output('status')
    
    unless /\AOn branch/ =~ output
      raise Peacock::PeacockError, 'you are not in a git repository.'
    end
  end
  
  def command_output(command = '', opts = '')
    f = command(command, opts)
    output = f.readlines.join
    f.close
    output
  end
  
  def command(command = '', opts = '')
    IO.popen("git #{command} #{opts} 2>&1")
  end
end
