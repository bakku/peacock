require 'minitest_helper'
require 'fileutils'

class TestStartupManager < Minitest::Test
  
  def test_git_repository_should_be_false
    startup = Peacock::StartupManager.new
    Dir.mkdir 'temptest'
    Dir.chdir 'temptest'
    refute startup.git_repository?
    Dir.chdir '..'
    Dir.rmdir 'temptest'
  end
  
  def test_git_repository_should_be_true
    startup = Peacock::StartupManager.new
    Dir.mkdir 'temptest'
    Dir.chdir 'temptest'
    Git.init
    assert startup.git_repository?
    Dir.chdir '..'
    FileUtils.rm_rf 'temptest'
  end
  
end
