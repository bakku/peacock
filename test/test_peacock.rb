require 'minitest_helper'

class TestPeacock < Minitest::Test
  
  def setup
    Dir.mkdir('/tmp/temptest')
    Dir.chdir('/tmp/temptest')
  end
  
  def teardown
    Dir.chdir('/tmp')
    FileUtils.rm_rf('/tmp/temptest')
  end
  
  def test_full
    Git.init
    FileUtils.touch('file.txt')
    Git.commit_all('test commit')
    ARGV[0] = 'file.txt'
    cli_hash = Peacock::CLI.parse
    Peacock::Engine::Ignorer.start_engine(cli_hash)
    system('echo hello > file.txt')
    str,o = Open3.capture2('git status')
    str
    assert str.match(/^nothing to commit, working directory clean$/)
  end
end
