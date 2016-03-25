require 'minitest_helper'

class TestIgnorer < Minitest::Test

  def setup
    Dir.mkdir '/tmp/peacock'
    Dir.chdir '/tmp/peacock'
    Git.init
  end

  def teardown
    FileUtils.rm_rf '/tmp/peacock'
    ARGV.clear
  end

  def test_should_create_gitignore_if_it_does_not_exist
    ignorer = Peacock::Engine::Ignorer.new(Peacock::CLIHash.new)
    ignorer.open_git_ignore
    File.exist? '.gitignore'
  end

end
