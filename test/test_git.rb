require 'minitest_helper'

class TestGit < Minitest::Test
  
  def setup
    Dir.mkdir '/tmp/temptest'
    Dir.chdir '/tmp/temptest'
  end
  
  def teardown
    Dir.chdir '/tmp'
    FileUtils.rm_rf 'temptest'
    ARGV.clear
  end
  
  def test_git_new_should_raise_exception
    assert_raises Peacock::PeacockError do
      Git.new
    end
  end
end