require 'minitest_helper'
require 'fileutils'

class TestStartupManager < Minitest::Test
  
  def setup
    @startup = Peacock::StartupManager.new
    Dir.mkdir '/tmp/temptest'
    Dir.chdir '/tmp/temptest'
  end
  
  def teardown
    Dir.chdir '/tmp'
    FileUtils.rm_rf 'temptest'
  end
  
  def test_git_repository_should_be_false
    refute @startup.git_repository?
  end
  
  def test_git_repository_should_be_true
    Git.init
    assert @startup.git_repository?  
  end
  
  def test_git_repository_nested_should_be_true
    Git.init
    Dir.mkdir 'test'
    Dir.chdir 'test'
    assert @startup.git_repository?
  end
  
  def test_check_git_repository_should_raise_exception
    assert_raises do
      @startup.check_git_repository
    end
  end
end
