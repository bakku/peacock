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

  def test_entry_exists_should_be_false
    ignorer = Peacock::Engine::Ignorer.new(Peacock::CLIHash.new)
    prepare_git_ignore
    ignorer.open_git_ignore
    refute ignorer.entry_exists? 'no_exist'
  end

  def test_entry_exists_should_be_true_for_correct_entry
    ignorer = Peacock::Engine::Ignorer.new(Peacock::CLIHash.new)
    prepare_git_ignore
    ignorer.open_git_ignore
    assert ignorer.entry_exists? 'file'
  end

  def test_entry_exists_should_be_true_for_entry_without_newline
    ignorer = Peacock::Engine::Ignorer.new(Peacock::CLIHash.new)
    prepare_git_ignore
    ignorer.open_git_ignore
    assert ignorer.entry_exists? 'directory'
  end

  private

  def prepare_git_ignore
    File.open('.gitignore', 'w') do |file|
      file.write "file\n"
      file.write "file2\n"
      file.write "directory"
    end
  end

end
