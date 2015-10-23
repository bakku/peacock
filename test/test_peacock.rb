require 'minitest_helper'
require 'fileutils'
require 'open3'

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
    parse_hash = Peacock::Parser.parse
    Peacock::Ignorer.ignore(parse_hash)
    system('echo hello > file.txt')
    str,o = Open3.capture2('git status')
    str
    assert str.match(/^nothing to commit, working directory clean$/)
  end
end
