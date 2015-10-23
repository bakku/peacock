require 'minitest_helper'

class TestIgnorer < Minitest::Test
  
  def setup
    @ignorer = Peacock::Ignorer.new(Peacock::CLIHash.new)
    Dir.mkdir '/tmp/temptest'
    Dir.chdir '/tmp/temptest'
  end
  
  def teardown
    Dir.chdir '/tmp'
    FileUtils.rm_rf 'temptest'
    ARGV.clear
  end
  
  def test_determine_root_dir_should_be_correct
    Git.init
    Dir.mkdir 'hello'
    Dir.chdir 'hello'
    Dir.mkdir 'bye'
    Dir.chdir 'bye'
    root_dir = @ignorer.determine_root_dir
    assert '/tmp/temptest/.gitignore' == root_dir || '/private/tmp/temptest/.gitignore' == root_dir
  end
  
end
