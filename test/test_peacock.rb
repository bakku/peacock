require 'minitest_helper'
require 'fileutils'

class TestPeacock < Minitest::Test
  
  def test_full
    Dir.mkdir 'temptest'
    Dir.chdir 'temptest'
    FileUtils.touch('file.txt')
    Git.commit_all('test_commit')
    ARGV[0] = 'file.txt'
    parse_hash = Peacock::Parser.parse
    Peacock::Ignorer.ignore(parse_hash)
    system('echo hello > file.txt')
    str,o = Open3.capture2('git status')
    assert str.match(/^nothing to commit, working directory clean$/)
    Dir.chdir '..'
    FileUtils.rm_rf 'temptest'
  end
end
