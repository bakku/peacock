require 'minitest_helper'
require 'fileutils'

class TestStartupManager < Minitest::Test
  include Peacock::StartupHelpers
  
  def test_git_repository_should_be_false
    Dir.mkdir 'temptest'
    Dir.chdir 'temptest'
    refute git_repository?
    Dir.chdir '..'
    Dir.rmdir 'temptest'
  end
  
  def test_git_repository_should_be_true
    Dir.mkdir 'temptest'
    Dir.chdir 'temptest'
    Git.init
    assert git_repository?
    Dir.chdir '..'
    FileUtils.rm_rf 'temptest'
  end
  
end
